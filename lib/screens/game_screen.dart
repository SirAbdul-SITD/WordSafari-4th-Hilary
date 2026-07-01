// lib/screens/game_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/game_provider.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import '../widgets/letter_tile_widget.dart';
import '../widgets/game_hud.dart';
import '../widgets/control_row.dart';
import 'level_complete_screen.dart';
import 'game_over_screen.dart';
import 'pause_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confetti;
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;
  late AnimationController _popCtrl;
  late Animation<double> _popAnim;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );

    _popCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _popAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _popCtrl, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _confetti.dispose();
    _shakeCtrl.dispose();
    _popCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    // React to game phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (game.showCorrectAnim) {
        _confetti.play();
        _popCtrl.forward(from: 0);
      }
      if (game.showWrongAnim) {
        _shakeCtrl.forward(from: 0);
      }
      if (game.phase == GamePhase.levelComplete) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LevelCompleteScreen()),
        );
      }
      if (game.phase == GamePhase.gameOver) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const GameOverScreen()),
        );
      }
      if (game.phase == GamePhase.paused) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PauseScreen()),
        );
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const GameHud(),
                  const SizedBox(height: 8),
                  _buildCategoryBanner(game),
                  const Spacer(),
                  _buildWordDisplay(game),
                  const SizedBox(height: 24),
                  _buildAnswerRow(game),
                  const SizedBox(height: 32),
                  _buildScrambleRow(game),
                  const SizedBox(height: 32),
                  const ControlRow(),
                  const Spacer(),
                ],
              ),
              // Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 30,
                  colors: const [
                    AppTheme.primary, AppTheme.secondary, AppTheme.accent,
                    AppTheme.purple, AppTheme.pink, AppTheme.green,
                  ],
                ),
              ),
              // Combo popup
              if (game.showCombo)
                _ComboPopup(label: game.comboLabel),
              // Blast overlay
              if (game.showBlastAnim)
                _BlastOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBanner(GameProvider game) {
    const emojis = {
      'Animals': '🐾', 'Food': '🍕', 'Sports': '⚽', 'Science': '🔬',
      'Countries': '🌍', 'Nature': '🌿', 'Technology': '💻', 'Emotions': '😊',
      'Music': '🎵', 'Travel': '✈️', 'Movies': '🎬', 'Mythology': '⚡',
      'Space': '🚀', 'History': '🏛️', 'Cooking': '👨‍🍳', 'Fashion': '👗',
      'Art': '🎨', 'Body': '🫀', 'Weather': '🌤️',
      'Sports Equipment': '🏋️', 'Professions': '👔',
    };
    final emoji = emojis[game.currentCategory] ?? '📝';

    String modeLabel = '';
    Color modeColor = AppTheme.primary;
    if (game.mode == GameMode.chain) {
      modeLabel = '⛓ CHAIN MODE';
      modeColor = AppTheme.secondary;
    } else if (game.mode == GameMode.blitz) {
      modeLabel = '⚡ BLITZ MODE';
      modeColor = AppTheme.purple;
    } else {
      modeLabel = '$emoji ${game.currentCategory} · Level ${game.currentLevel}';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: modeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: modeColor.withOpacity(0.3)),
      ),
      child: Text(
        modeLabel,
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 16,
          color: modeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWordDisplay(GameProvider game) {
    // Show word length hint
    final wordLen = game.currentWord.length;

    // Chain connector
    Widget? chainHint;
    if (game.mode == GameMode.chain && game.chainConnector.isNotEmpty) {
      chainHint = Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.link_rounded, color: AppTheme.secondary, size: 16),
            const SizedBox(width: 6),
            Text(
              'Must start with "${game.chainConnector.toUpperCase()}"',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                color: AppTheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (chainHint != null) chainHint,
        Text(
          '$wordLen letter word',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            color: AppTheme.textMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerRow(GameProvider game) {
    final size = _tileSize(game.currentWord.length, context);

    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (context, child) {
        final offset = game.showWrongAnim
            ? (8 * (0.5 - (_shakeAnim.value % 0.25) / 0.25).abs())
            : 0.0;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(game.currentWord.length, (i) {
            return AnswerSlotWidget(
              tile: game.answerSlots.length > i ? game.answerSlots[i] : null,
              onTap: () => game.unselectTile(i),
              size: size,
              index: i,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildScrambleRow(GameProvider game) {
    final size = _tileSize(game.scrambledWord.length, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: game.scrambledTiles.asMap().entries.map((e) {
          return AnimatedBuilder(
            animation: _popAnim,
            builder: (ctx, child) {
              return Transform.scale(
                scale: game.showCorrectAnim
                    ? (0.8 + 0.2 * _popAnim.value)
                    : 1.0,
                child: child,
              );
            },
            child: LetterTileWidget(
              tile: e.value,
              onTap: () => game.tapTile(e.key),
              size: size,
            ),
          );
        }).toList(),
      ),
    );
  }

  double _tileSize(int wordLen, BuildContext context) {
    final w = MediaQuery.of(context).size.width - 40;
    final maxTileSize = 64.0;
    final spacing = 10.0 * (wordLen - 1);
    return ((w - spacing) / wordLen).clamp(40.0, maxTileSize);
  }
}

// Combo popup overlay
class _ComboPopup extends StatefulWidget {
  final String label;
  const _ComboPopup({required this.label});

  @override
  State<_ComboPopup> createState() => _ComboPopupState();
}

class _ComboPopupState extends State<_ComboPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _scale = Tween<double>(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.3)),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.pink],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: AppTheme.buttonShadow(AppTheme.primary),
              ),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Blast overlay
class _BlastOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.accent.withOpacity(0.3),
      child: const Center(
        child: Text(
          '💥 BLAST BONUS!',
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
