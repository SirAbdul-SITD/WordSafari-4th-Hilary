// lib/widgets/control_row.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';

class ControlRow extends StatelessWidget {
  const ControlRow({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Hint button
          _ControlButton(
            label: 'Hint',
            icon: '💡',
            sublabel: '10🪙',
            color: AppTheme.accent,
            textColor: const Color(0xFF996600),
            onTap: () async {
              final success = await game.useHint();
              if (!success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Not enough coins!'),
                    duration: Duration(seconds: 1),
                    backgroundColor: AppTheme.red,
                  ),
                );
              }
            },
          ),

          // Clear button
          _ControlButton(
            label: 'Clear',
            icon: '↩️',
            color: AppTheme.textLight.withOpacity(0.5),
            textColor: AppTheme.textMedium,
            onTap: game.clearAnswer,
          ),

          // Shuffle button
          _ControlButton(
            label: 'Shuffle',
            icon: '🔀',
            color: AppTheme.purple.withOpacity(0.2),
            textColor: AppTheme.purple,
            onTap: game.shuffle,
          ),

          // Freeze (Blitz only)
          if (game.mode == GameMode.blitz)
            _ControlButton(
              label: 'Freeze',
              icon: '❄️',
              sublabel: '20🪙',
              color: AppTheme.secondary.withOpacity(0.2),
              textColor: AppTheme.secondary,
              onTap: game.activateFreeze,
            ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String label;
  final String icon;
  final String? sublabel;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ControlButton({
    required this.label,
    required this.icon,
    this.sublabel,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: textColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            if (sublabel != null)
              Text(
                sublabel!,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 10,
                  color: textColor.withOpacity(0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
