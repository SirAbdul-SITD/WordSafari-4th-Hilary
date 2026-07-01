// lib/widgets/game_hud.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';

class GameHud extends StatelessWidget {
  const GameHud({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back / pause
          _HudButton(
            icon: Icons.pause_rounded,
            onTap: game.pauseGame,
            color: AppTheme.purple,
          ),
          // Score
          _ScoreBadge(score: game.score),
          // Mode specific
          if (game.mode == GameMode.blitz)
            _TimerBadge(seconds: game.blitzStats.timeRemaining,
                frozen: game.blitzStats.isFrozen)
          else if (game.mode == GameMode.chain)
            _LivesBadge(lives: game.livesRemaining)
          else
            _ProgressBadge(
              current: game.wordIndex + 1,
              total: game.levelWords.length,
            ),
          // Coins
          _CoinsBadge(coins: game.coins),
        ],
      ),
    );
  }
}

class _HudButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _HudButton({required this.icon, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Icon(icon, color: color, size: 22),
    ),
  );
}

class _ScoreBadge extends StatelessWidget {
  final int score;
  const _ScoreBadge({required this.score});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      gradient: AppTheme.primaryGradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: AppTheme.buttonShadow(AppTheme.primary),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, color: AppTheme.accent, size: 18),
        const SizedBox(width: 6),
        Text(
          score.toString(),
          style: const TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class _TimerBadge extends StatelessWidget {
  final int seconds;
  final bool frozen;
  const _TimerBadge({required this.seconds, required this.frozen});

  @override
  Widget build(BuildContext context) {
    final isLow = seconds <= 10 && !frozen;
    final color = frozen ? AppTheme.secondary : (isLow ? AppTheme.red : AppTheme.blue);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            frozen ? Icons.ac_unit_rounded : Icons.timer_rounded,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '${seconds}s',
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LivesBadge extends StatelessWidget {
  final int lives;
  const _LivesBadge({required this.lives});

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(3, (i) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(
        Icons.favorite_rounded,
        color: i < lives ? AppTheme.red : AppTheme.textLight,
        size: 24,
      ),
    )),
  );
}

class _ProgressBadge extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBadge({required this.current, required this.total});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: AppTheme.secondary.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppTheme.secondary.withOpacity(0.4)),
    ),
    child: Text(
      '$current/$total',
      style: const TextStyle(
        fontFamily: 'Fredoka',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.secondary,
      ),
    ),
  );
}

class _CoinsBadge extends StatelessWidget {
  final int coins;
  const _CoinsBadge({required this.coins});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: AppTheme.accent.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppTheme.accent.withOpacity(0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🪙', style: TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          coins.toString(),
          style: const TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF996600),
          ),
        ),
      ],
    ),
  );
}
