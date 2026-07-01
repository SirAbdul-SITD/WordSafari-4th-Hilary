// lib/screens/game_over_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import 'menu_screen.dart';
import 'game_screen.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameProvider>();
    final isBlitz = game.mode == GameMode.blitz;
    final blitzBest = StorageService.getBlitzHighScore();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('😔', style: TextStyle(fontSize: 72)),
                  const SizedBox(height: 16),
                  Text(
                    isBlitz ? 'Time\'s Up!' : 'Game Over!',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.red,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (isBlitz) ...[
                    _StatCard(
                      label: 'Words Solved',
                      value: game.blitzStats.wordsCompleted.toString(),
                      icon: '📝',
                    ),
                    const SizedBox(height: 10),
                    _StatCard(
                      label: 'Best Streak',
                      value: '${game.blitzStats.longestStreak}x',
                      icon: '🔥',
                    ),
                    const SizedBox(height: 10),
                    _StatCard(
                      label: 'Score',
                      value: game.blitzStats.score.toString(),
                      icon: '🏆',
                    ),
                    const SizedBox(height: 10),
                    _StatCard(
                      label: 'Personal Best',
                      value: blitzBest.toString(),
                      icon: '⭐',
                      highlight: game.blitzStats.score >= blitzBest,
                    ),
                  ] else ...[
                    _StatCard(
                      label: 'Score',
                      value: game.score.toString(),
                      icon: '🏆',
                    ),
                    const SizedBox(height: 10),
                    _StatCard(
                      label: 'Streak',
                      value: '${game.streak}x',
                      icon: '🔥',
                    ),
                  ],
                  const SizedBox(height: 40),
                  _RetryButton(
                    onTap: () => _retry(context, game),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MenuScreen()),
                      (_) => false,
                    ),
                    child: Text(
                      'Back to Menu',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: AppTheme.textMedium,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _retry(BuildContext context, GameProvider game) {
    if (game.mode == GameMode.blitz) {
      game.startBlitzMode();
    } else if (game.mode == GameMode.chain) {
      game.startChainMode();
    } else {
      game.startClassicLevel(game.currentCategory, game.currentLevel);
    }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const GameScreen()));
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final bool highlight;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    decoration: BoxDecoration(
      color: highlight ? AppTheme.accent.withOpacity(0.15) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: highlight
          ? Border.all(color: AppTheme.accent, width: 2)
          : null,
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
        Row(children: [
          if (highlight) ...[
            const Icon(Icons.star_rounded, color: AppTheme.accent, size: 18),
            const SizedBox(width: 4),
          ],
          Text(value, style: const TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          )),
        ]),
      ],
    ),
  );
}

class _RetryButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RetryButton({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.buttonShadow(AppTheme.primary),
      ),
      child: const Center(
        child: Text(
          'Try Again',
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
