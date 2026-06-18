// lib/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../data/word_bank.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import 'level_select_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const Map<String, String> categoryEmojis = {
    'Animals': '🐾',
    'Food': '🍕',
    'Sports': '⚽',
    'Science': '🔬',
    'Countries': '🌍',
    'Nature': '🌿',
    'Technology': '💻',
    'Emotions': '😊',
    'Music': '🎵',
    'Travel': '✈️',
    'Movies': '🎬',
    'Mythology': '⚡',
    'Space': '🚀',
    'History': '🏛️',
    'Cooking': '👨‍🍳',
    'Fashion': '👗',
    'Art': '🎨',
    'Body': '🫀',
    'Weather': '🌤️',
    'Sports Equipment': '🏋️',
    'Professions': '👔',
  };

  static const List<Color> categoryColors = [
    AppTheme.primary,
    AppTheme.secondary,
    AppTheme.purple,
    AppTheme.pink,
    AppTheme.green,
    AppTheme.blue,
    Color(0xFFFF9F1C),
    AppTheme.red,
    Color(0xFF2EC4B6),
    Color(0xFF06D6A0),
    Color(0xFF118AB2),
    Color(0xFF9B5DE5),
    Color(0xFFFF6B9D),
    Color(0xFFFFBE0B),
    Color(0xFFEF476F),
    Color(0xFF4ECDC4),
    Color(0xFFFF8C42),
    Color(0xFF44A3BB),
    Color(0xFF6A4C93),
    Color(0xFF1982C4),
    Color(0xFF8AC926),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = WordBank.allCategories;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: AppTheme.primary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Choose Category',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              // Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, i) {
                    final cat = categories[i];
                    final color = categoryColors[i % categoryColors.length];
                    final emoji = categoryEmojis[cat] ?? '📝';

                    // Count completed levels
                    int completedLevels = 0;
                    int totalStars = 0;
                    for (int l = 1; l <= 10; l++) {
                      final p = StorageService.getLevelProgress(cat, l);
                      if (p.stars > 0) {
                        completedLevels++;
                        totalStars += p.stars;
                      }
                    }

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LevelSelectScreen(
                              category: cat, color: color),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: AppTheme.cardShadow,
                          border: Border.all(
                              color: color.withOpacity(0.3), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50, height: 50,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(emoji,
                                    style: const TextStyle(fontSize: 28)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cat,
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$completedLevels/10',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                if (totalStars > 0) ...[
                                  const Icon(Icons.star_rounded,
                                      color: AppTheme.accent, size: 14),
                                  Text(
                                    totalStars.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 12,
                                      color: AppTheme.textMedium,
                                    ),
                                  ),
                                ],
                              ],
                            ),
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
}
