// lib/utils/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_models.dart';

class StorageService {
  static const _coinsKey = 'coins';
  static const _blitzHighScoreKey = 'blitz_high_score';
  static const _totalStarsKey = 'total_stars';
  static const _soundEnabledKey = 'sound_enabled';
  static const _musicEnabledKey = 'music_enabled';
  static const _levelProgressPrefix = 'level_';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Coins
  static int getCoins() => _prefs?.getInt(_coinsKey) ?? 100;
  static Future<void> setCoins(int coins) async =>
      await _prefs?.setInt(_coinsKey, coins);
  static Future<void> addCoins(int amount) async =>
      await setCoins(getCoins() + amount);
  static Future<bool> spendCoins(int amount) async {
    final current = getCoins();
    if (current < amount) return false;
    await setCoins(current - amount);
    return true;
  }

  // Blitz high score
  static int getBlitzHighScore() => _prefs?.getInt(_blitzHighScoreKey) ?? 0;
  static Future<void> setBlitzHighScore(int score) async {
    if (score > getBlitzHighScore()) {
      await _prefs?.setInt(_blitzHighScoreKey, score);
    }
  }

  // Total stars
  static int getTotalStars() => _prefs?.getInt(_totalStarsKey) ?? 0;
  static Future<void> addStars(int stars) async =>
      await _prefs?.setInt(_totalStarsKey, getTotalStars() + stars);

  // Level progress
  static LevelProgress getLevelProgress(String category, int level) {
    final key = '$_levelProgressPrefix${category}_$level';
    final json = _prefs?.getString(key);
    if (json == null) {
      return LevelProgress(
        category: category,
        level: level,
        isUnlocked: level == 1, // First level always unlocked
      );
    }
    return LevelProgress.fromJson(jsonDecode(json));
  }

  static Future<void> saveLevelProgress(LevelProgress progress) async {
    final key = '$_levelProgressPrefix${progress.category}_${progress.level}';
    await _prefs?.setString(key, jsonEncode(progress.toJson()));

    // Unlock next level
    if (progress.stars > 0 && progress.level < 10) {
      final nextLevel = getLevelProgress(progress.category, progress.level + 1);
      if (!nextLevel.isUnlocked) {
        nextLevel.isUnlocked = true;
        await saveLevelProgress(nextLevel);
      }
    }
  }

  static Map<int, LevelProgress> getAllLevelsForCategory(String category) {
    final result = <int, LevelProgress>{};
    for (int i = 1; i <= 10; i++) {
      result[i] = getLevelProgress(category, i);
    }
    return result;
  }

  // Settings
  static bool getSoundEnabled() => _prefs?.getBool(_soundEnabledKey) ?? true;
  static Future<void> setSoundEnabled(bool v) async =>
      await _prefs?.setBool(_soundEnabledKey, v);

  static bool getMusicEnabled() => _prefs?.getBool(_musicEnabledKey) ?? true;
  static Future<void> setMusicEnabled(bool v) async =>
      await _prefs?.setBool(_musicEnabledKey, v);
}
