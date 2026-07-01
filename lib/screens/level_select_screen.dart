// lib/screens/level_select_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  final String category;
  final Color color;

  const LevelSelectScreen({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(Icons.arrow_back_rounded, color: color),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      category,
                      style: const TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              // Level grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    final level = i + 1;
                    final progress = StorageService.getLevelProgress(category, level);
                    final isUnlocked = progress.isUnlocked;
                    final stars = progress.stars;

                    return GestureDetector(
                      onTap: isUnlocked
                          ? () => _startLevel(context, level)
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isUnlocked ? Colors.white : AppTheme.textLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isUnlocked ? AppTheme.cardShadow : [],
                          border: Border.all(
                            color: isUnlocked
                                ? (stars > 0 ? color : color.withOpacity(0.3))
                                : Colors.transparent,
                            width: stars > 0 ? 2.5 : 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isUnlocked)
                              Icon(Icons.lock_rounded,
                                  color: AppTheme.textLight, size: 28)
                            else ...[
                              Text(
                                level.toString(),
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: stars > 0 ? color : AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (si) => Icon(
                                  si < stars
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  color: AppTheme.accent,
                                  size: 16,
                                )),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startLevel(BuildContext context, int level) {
    final game = context.read<GameProvider>();
    game.startClassicLevel(category, level);
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const GameScreen()));
  }
}
