// lib/models/game_provider.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../data/word_bank.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import '../utils/score_calculator.dart';
import '../utils/audio_service.dart';

enum GamePhase { idle, playing, wordComplete, levelComplete, gameOver, paused }

class GameProvider extends ChangeNotifier {
  // ── Game state ───────────────────────────────────────────────────
  GameMode mode = GameMode.classic;
  GamePhase phase = GamePhase.idle;
  String currentCategory = 'Animals';
  int currentLevel = 1;

  // ── Current puzzle ───────────────────────────────────────────────
  List<LetterTile> scrambledTiles = [];
  List<LetterTile?> answerSlots = [];
  String currentWord = '';
  String scrambledWord = '';
  int wordIndex = 0;
  List<String> levelWords = [];
  int hintsUsed = 0;
  int _wordStartTime = 0;

  // ── Score & progress ─────────────────────────────────────────────
  int score = 0;
  int streak = 0;
  int coins = 0;
  int totalStars = 0;
  List<int> wordStars = [];

  // ── Chain mode ───────────────────────────────────────────────────
  List<ChainLink> chainLinks = [];
  int chainIndex = 0;
  int livesRemaining = 3;
  String chainConnector = '';

  // ── Blitz mode ───────────────────────────────────────────────────
  BlitzStats blitzStats = BlitzStats();
  Timer? _blitzTimer;
  bool _freezeActive = false;

  // ── Animation flags ──────────────────────────────────────────────
  bool showCorrectAnim = false;
  bool showWrongAnim = false;
  bool showBlastAnim = false;
  String comboLabel = '';
  bool showCombo = false;

  final Random _rng = Random();

  // ──────────────────────────────────────────────────────────────────

  Future<void> startClassicLevel(String category, int level) async {
    mode = GameMode.classic;
    currentCategory = category;
    currentLevel = level;
    score = 0;
    streak = 0;
    wordIndex = 0;
    wordStars = [];
    hintsUsed = 0;
    coins = StorageService.getCoins();

    // Collect words from ALL levels of this category (up to 100), then shuffle
    final allWords = <String>[];
    for (int l = 1; l <= 10; l++) {
      allWords.addAll(WordBank.getWordsForLevel(category, l));
    }
    // Use a fresh Random seeded by time so order is different each session
    final rng = Random(DateTime.now().millisecondsSinceEpoch);
    allWords.shuffle(rng);
    // Remove duplicates, take up to 100
    levelWords = allWords.toSet().toList()..shuffle(rng);
    if (levelWords.length > 100) levelWords = levelWords.sublist(0, 100);

    phase = GamePhase.playing;
    _loadCurrentWord();
    notifyListeners();
  }

  Future<void> startChainMode() async {
    mode = GameMode.chain;
    score = 0;
    streak = 0;
    chainIndex = 0;
    livesRemaining = 3;
    coins = StorageService.getCoins();

    // Build word chain
    _buildChain();

    phase = GamePhase.playing;
    _loadChainWord();
    notifyListeners();
  }

  Future<void> startBlitzMode() async {
    mode = GameMode.blitz;
    blitzStats = BlitzStats();
    coins = StorageService.getCoins();

    // Pick random word
    _loadBlitzWord();

    phase = GamePhase.playing;
    _startBlitzTimer();
    notifyListeners();
  }

  void _buildChain() {
    // Gather all available words across all categories and levels
    final allWords = <String>[];
    for (final cat in WordBank.allCategories) {
      for (int l = 1; l <= 10; l++) {
        allWords.addAll(WordBank.getWordsForLevel(cat, l));
      }
    }
    // Deduplicate
    final wordSet = allWords.toSet().toList();
    wordSet.shuffle(_rng);

    chainLinks = [];
    String? requiredStart; // the letter the NEXT word must START with

    for (final word in wordSet) {
      if (word.length < 3) continue; // skip very short words
      if (requiredStart == null || word[0] == requiredStart) {
        // This word fits — add it
        // The NEXT word must start with the LAST letter of this word
        final nextRequired = word[word.length - 1];
        chainLinks.add(ChainLink(
          word: word,
          connectingLetter: nextRequired, // last letter → required first of next
        ));
        requiredStart = nextRequired;
        if (chainLinks.length >= 15) break;
      }
    }

    // Fallback if we couldn't build a proper chain
    if (chainLinks.length < 5) {
      chainLinks = [];
      // Build a guaranteed manual chain
      const manualChain = [
        'bear', 'rabbit', 'tiger', 'raven', 'newt',
        'turtle', 'eagle', 'emu', 'umbrella', 'ant',
      ];
      String? req;
      for (final w in manualChain) {
        if (req == null || w[0] == req) {
          chainLinks.add(ChainLink(word: w, connectingLetter: w[w.length - 1]));
          req = w[w.length - 1];
        }
      }
    }
  }

  void _loadCurrentWord() {
    if (wordIndex >= levelWords.length) {
      _completLevel();
      return;
    }

    currentWord = levelWords[wordIndex];
    scrambledWord = _scramble(currentWord);
    hintsUsed = 0;
    _wordStartTime = DateTime.now().millisecondsSinceEpoch;
    _buildTiles(scrambledWord);
  }

  void _loadChainWord() {
    if (chainIndex >= chainLinks.length) {
      _completLevel();
      return;
    }
    currentWord = chainLinks[chainIndex].word;
    scrambledWord = _scramble(currentWord);

    // The connector shown to the player is the FIRST letter of the current word
    // (which equals the last letter of the previous word)
    // Only show it from word 2 onwards
    chainConnector = chainIndex > 0 ? currentWord[0] : '';

    hintsUsed = 0;
    _wordStartTime = DateTime.now().millisecondsSinceEpoch;
    _buildTiles(scrambledWord);
  }

  void _loadBlitzWord() {
    final cats = WordBank.allCategories;
    final cat = cats[_rng.nextInt(cats.length)];
    final level = _rng.nextInt(5) + 1;
    final words = WordBank.getWordsForLevel(cat, level);
    currentWord = words[_rng.nextInt(words.length)];
    scrambledWord = _scramble(currentWord);
    hintsUsed = 0;
    _wordStartTime = DateTime.now().millisecondsSinceEpoch;
    _buildTiles(scrambledWord);
  }

  String _scramble(String word) {
    if (word.length <= 1) return word;
    final chars = word.split('');
    // Use time-based seed so it differs every call
    final rng = Random(DateTime.now().microsecondsSinceEpoch);
    int attempts = 0;
    do {
      chars.shuffle(rng);
      attempts++;
    } while (chars.join() == word && attempts < 50);
    return chars.join();
  }

  void _buildTiles(String scrambled) {
    // IMPORTANT: Build tiles from scrambled letters directly.
    // Each tile letter must come from scrambled, not currentWord,
    // so the player sees and taps the actual shuffled letters.
    scrambledTiles = List.generate(scrambled.length, (i) {
      final isBlast = _rng.nextDouble() < 0.15;
      final colorIndex = _rng.nextInt(AppTheme.tileColors.length);
      return LetterTile(
        letter: scrambled[i], // letter from scrambled string
        index: i,
        isBlast: isBlast,
        color: AppTheme.tileColors[colorIndex],
      );
    });
    answerSlots = List.filled(scrambled.length, null);
    notifyListeners();
  }

  // ── Tap handler ──────────────────────────────────────────────────
  void tapTile(int tileIndex) {
    if (phase != GamePhase.playing) return;
    final tile = scrambledTiles[tileIndex];
    if (tile.state != TileState.idle) return;

    AudioService.playTap();

    // Find next empty slot
    final slotIndex = answerSlots.indexWhere((s) => s == null);
    if (slotIndex == -1) return;

    scrambledTiles[tileIndex] = tile.copyWith(state: TileState.selected);
    answerSlots[slotIndex] = tile;
    notifyListeners();

    // Check if all slots filled
    if (!answerSlots.contains(null)) {
      _checkAnswer();
    }
  }

  void unselectTile(int slotIndex) {
    if (phase != GamePhase.playing) return;
    final tile = answerSlots[slotIndex];
    if (tile == null) return;

    // Restore tile to scramble row
    final tileIdx = scrambledTiles.indexWhere((t) => t.index == tile.index);
    if (tileIdx != -1) {
      scrambledTiles[tileIdx] = tile.copyWith(state: TileState.idle);
    }
    answerSlots[slotIndex] = null;

    // Shift remaining slots left
    final newSlots = List<LetterTile?>.filled(currentWord.length, null);
    int pos = 0;
    for (final s in answerSlots) {
      if (s != null) newSlots[pos++] = s;
    }
    answerSlots = newSlots;
    notifyListeners();
  }

  void _checkAnswer() {
    final attempt = answerSlots.map((t) => t?.letter ?? '').join().toLowerCase().trim();
    final target = currentWord.toLowerCase().trim();
    final hasBlast = answerSlots.any((t) => t?.isBlast == true);

    if (attempt == target) {
      _handleCorrect(hasBlast);
    } else {
      _handleWrong();
    }
  }

  void _handleCorrect(bool hasBlast) async {
    streak++;
    final timeUsed = (DateTime.now().millisecondsSinceEpoch - _wordStartTime) ~/ 1000;
    final wordScore = ScoreCalculator.calculateWordScore(
      word: currentWord,
      hintsUsed: hintsUsed,
      timeUsed: timeUsed,
      hasBlastTile: hasBlast,
      streak: streak,
    );
    score += wordScore;

    // Combo label
    final label = ScoreCalculator.streakLabel(streak);
    if (label.isNotEmpty) {
      comboLabel = label;
      showCombo = true;
      Future.delayed(const Duration(seconds: 2), () {
        showCombo = false;
        notifyListeners();
      });
    }

    // Mark tiles correct
    for (int i = 0; i < answerSlots.length; i++) {
      final t = answerSlots[i];
      if (t != null) {
        final idx = scrambledTiles.indexWhere((st) => st.index == t.index);
        if (idx != -1) scrambledTiles[idx] = t.copyWith(state: TileState.correct);
        answerSlots[i] = t.copyWith(state: TileState.correct);
      }
    }
    showCorrectAnim = true;
    if (hasBlast) {
      showBlastAnim = true;
      AudioService.playBlast();
    } else {
      AudioService.playCorrect();
    }

    if (streak >= 3) AudioService.playCombo(streak);

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    showCorrectAnim = false;
    showBlastAnim = false;

    if (mode == GameMode.classic) {
      final stars = _calcStars(hintsUsed, timeUsed);
      wordStars.add(stars);
      wordIndex++;
      _loadCurrentWord();
    } else if (mode == GameMode.chain) {
      chainLinks[chainIndex].isSolved = true;
      chainIndex++;
      _loadChainWord();
    } else if (mode == GameMode.blitz) {
      blitzStats.score += ScoreCalculator.calculateBlitzScore(
        word: currentWord, streak: streak);
      blitzStats.wordsCompleted++;
      blitzStats.currentStreak++;
      if (blitzStats.currentStreak > blitzStats.longestStreak) {
        blitzStats.longestStreak = blitzStats.currentStreak;
      }
      _loadBlitzWord();
    }
  }

  void _handleWrong() async {
    streak = 0;
    showWrongAnim = true;
    AudioService.playWrong();

    // Shake animation flag
    for (int i = 0; i < answerSlots.length; i++) {
      final t = answerSlots[i];
      if (t != null) answerSlots[i] = t.copyWith(state: TileState.wrong);
    }
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    showWrongAnim = false;

    if (mode == GameMode.chain) {
      livesRemaining--;
      if (livesRemaining <= 0) {
        phase = GamePhase.gameOver;
        AudioService.playGameOver();
        notifyListeners();
        return;
      }
    }

    // Restore tiles from the SAME scrambledWord (don't re-scramble)
    _buildTiles(scrambledWord);
  }

  int _calcStars(int hints, int timeUsed) {
    if (hints == 0 && timeUsed < 10) return 3;
    if (hints <= 1 && timeUsed < 30) return 2;
    return 1;
  }

  // ── Hint ─────────────────────────────────────────────────────────
  Future<bool> useHint() async {
    final cost = 10;
    if (!await StorageService.spendCoins(cost)) return false;
    coins = StorageService.getCoins();
    hintsUsed++;
    AudioService.playHint();

    // Find first unfilled correct slot
    for (int i = 0; i < answerSlots.length; i++) {
      if (answerSlots[i] == null) {
        // Find correct letter in scramble (case-insensitive)
        final correctLetter = currentWord[i].toLowerCase();
        final tileIdx = scrambledTiles.indexWhere(
          (t) => t.letter.toLowerCase() == correctLetter && t.state == TileState.idle,
        );
        if (tileIdx != -1) {
          tapTile(tileIdx);
        }
        break;
      }
    }
    notifyListeners();
    return true;
  }

  // ── Shuffle ───────────────────────────────────────────────────────
  void shuffle() {
    AudioService.playShuffle();
    // Only shuffle idle tiles
    final idleTiles = scrambledTiles.where((t) => t.state == TileState.idle).toList();
    idleTiles.shuffle(_rng);
    int idx = 0;
    for (int i = 0; i < scrambledTiles.length; i++) {
      if (scrambledTiles[i].state == TileState.idle) {
        scrambledTiles[i] = idleTiles[idx++].copyWith();
      }
    }
    notifyListeners();
  }

  // ── Clear answer ──────────────────────────────────────────────────
  void clearAnswer() {
    for (int i = answerSlots.length - 1; i >= 0; i--) {
      if (answerSlots[i] != null) unselectTile(i);
    }
  }

  // ── Blitz timer ───────────────────────────────────────────────────
  void _startBlitzTimer() {
    _blitzTimer?.cancel();
    _blitzTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (phase != GamePhase.playing) { t.cancel(); return; }
      if (_freezeActive) return;
      blitzStats.timeRemaining--;
      if (blitzStats.timeRemaining <= 0) {
        _blitzTimer?.cancel();
        phase = GamePhase.gameOver;
        AudioService.playGameOver();
        StorageService.setBlitzHighScore(blitzStats.score);
      }
      notifyListeners();
    });
  }

  Future<void> activateFreeze() async {
    final cost = 20;
    if (!await StorageService.spendCoins(cost)) return;
    coins = StorageService.getCoins();
    _freezeActive = true;
    blitzStats.isFrozen = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    _freezeActive = false;
    blitzStats.isFrozen = false;
    notifyListeners();
  }

  // ── Level complete ────────────────────────────────────────────────
  void _completLevel() async {
    phase = GamePhase.levelComplete;
    AudioService.playLevelComplete();

    final totalStarsEarned = wordStars.fold(0, (a, b) => a + b);
    final coinsEarned = ScoreCalculator.coinsFromStars(totalStarsEarned);

    await StorageService.addCoins(coinsEarned);
    await StorageService.addStars(totalStarsEarned);
    coins = StorageService.getCoins();

    // Save level progress
    final progress = StorageService.getLevelProgress(currentCategory, currentLevel);
    if (totalStarsEarned > progress.stars) progress.stars = totalStarsEarned;
    if (score > progress.highScore) progress.highScore = score;
    progress.isUnlocked = true;
    await StorageService.saveLevelProgress(progress);

    notifyListeners();
  }

  void pauseGame() {
    if (phase == GamePhase.playing) {
      phase = GamePhase.paused;
      _blitzTimer?.cancel();
      notifyListeners();
    }
  }

  void resumeGame() {
    if (phase == GamePhase.paused) {
      phase = GamePhase.playing;
      if (mode == GameMode.blitz) _startBlitzTimer();
      notifyListeners();
    }
  }

  void resetGame() {
    phase = GamePhase.idle;
    _blitzTimer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _blitzTimer?.cancel();
    super.dispose();
  }
}
