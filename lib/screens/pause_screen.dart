// lib/screens/pause_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../theme/app_theme.dart';
import 'menu_screen.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('⏸', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              const Text(
                'Paused',
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 28),
              _PauseButton(
                label: 'Resume',
                gradient: AppTheme.primaryGradient,
                onTap: () {
                  context.read<GameProvider>().resumeGame();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              _PauseButton(
                label: 'Quit to Menu',
                gradient: const LinearGradient(
                  colors: [Color(0xFFF0F0F0), Color(0xFFE0E0E0)],
                ),
                textColor: AppTheme.textDark,
                onTap: () {
                  context.read<GameProvider>().resetGame();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MenuScreen()),
                    (_) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  final String label;
  final Gradient gradient;
  final VoidCallback onTap;
  final Color textColor;

  const _PauseButton({
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
