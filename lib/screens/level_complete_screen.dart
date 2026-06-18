// lib/screens/level_complete_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/game_provider.dart';
import '../theme/app_theme.dart';
import 'menu_screen.dart';
import 'game_screen.dart';

class LevelCompleteScreen extends StatefulWidget {
  const LevelCompleteScreen({super.key});

  @override
  State<LevelCompleteScreen> createState() => _LevelCompleteScreenState();
}

class _LevelCompleteScreenState extends State<LevelCompleteScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confetti;
  late AnimationController _ctrl;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3))..play();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeIn = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _confetti.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameProvider>();
    final totalStars = game.wordStars.fold(0, (a, b) => a + b);
    final maxStars = game.wordStars.length * 3;
    final coinsEarned = totalStars * 5;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Stack(
            children: [
              FadeTransition(
                opacity: _fadeIn,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 16),
                        const Text(
                          'Level Complete!',
                          style: TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _StarDisplay(stars: totalStars, max: maxStars),
                        const SizedBox(height: 24),
                        _StatRow(label: 'Score', value: game.score.toString(), icon: '🏆'),
                        const SizedBox(height: 8),
                        _StatRow(label: 'Coins earned', value: '+$coinsEarned', icon: '🪙'),
                        const SizedBox(height: 40),
                        // Buttons
                        _BigButton(
                          label: 'Next Level',
                          gradient: AppTheme.primaryGradient,
                          onTap: () => _nextLevel(context, game),
                        ),
                        const SizedBox(height: 12),
                        _BigButton(
                          label: 'Menu',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF0F0F0), Color(0xFFE0E0E0)],
                          ),
                          textColor: AppTheme.textDark,
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const MenuScreen()),
                            (_) => false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 40,
                  colors: const [
                    AppTheme.primary, AppTheme.secondary, AppTheme.accent,
                    AppTheme.purple, AppTheme.pink, AppTheme.green,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextLevel(BuildContext context, GameProvider game) {
    final next = game.currentLevel + 1;
    if (next <= 10) {
      game.startClassicLevel(game.currentCategory, next);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const GameScreen()));
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MenuScreen()),
        (_) => false,
      );
    }
  }
}

class _StarDisplay extends StatelessWidget {
  final int stars;
  final int max;
  const _StarDisplay({required this.stars, required this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(max > 15 ? 15 : max, (i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Icon(
          i < stars ? Icons.star_rounded : Icons.star_border_rounded,
          color: AppTheme.accent,
          size: 32,
        ),
      )),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  const _StatRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: AppTheme.cardShadow,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Text(label, style: AppTheme.bodyLarge),
        ]),
        Text(value, style: const TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        )),
      ],
    ),
  );
}

class _BigButton extends StatelessWidget {
  final String label;
  final Gradient gradient;
  final VoidCallback onTap;
  final Color textColor;

  const _BigButton({
    required this.label,
    required this.gradient,
    required this.onTap,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
