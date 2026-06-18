// lib/screens/how_to_play_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  static const List<Map<String, dynamic>> steps = [
    {'emoji': '👀', 'title': 'Look at the scrambled word', 'desc': 'Letters are shuffled — figure out the hidden word from the category hint.'},
    {'emoji': '👆', 'title': 'Tap letters to spell it', 'desc': 'Tap scrambled letters one by one to build your answer in the slots above.'},
    {'emoji': '↩️', 'title': 'Made a mistake?', 'desc': 'Tap any filled slot to remove that letter and try again. Or press Clear to reset.'},
    {'emoji': '💡', 'title': 'Need a hint?', 'desc': 'Use the Hint button (costs 10 coins) to reveal one correct letter position.'},
    {'emoji': '🔀', 'title': 'Stuck? Try Shuffle!', 'desc': 'Reshuffle the scrambled letters for a fresh perspective. It is free!'},
    {'emoji': '💥', 'title': 'Watch for Blast tiles!', 'desc': 'Yellow-dotted tiles are Blast tiles. Use them in your word for a 2x score bonus!'},
    {'emoji': '🔥', 'title': 'Build streaks!', 'desc': 'Solve words in a row without mistakes to build a streak multiplier for massive points.'},
    {'emoji': '⭐', 'title': 'Earn stars', 'desc': '3 stars: no hints, fast solve. 2 stars: 1 hint. 1 star: completed. Stars unlock more levels!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                        child: const Icon(Icons.arrow_back_rounded, color: AppTheme.primary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text('How to Play', style: TextStyle(fontFamily: 'Fredoka', fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: steps.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final step = steps[i];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                            child: Center(child: Text(step['emoji'], style: const TextStyle(fontSize: 28))),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(step['title'], style: const TextStyle(fontFamily: 'Fredoka', fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                              const SizedBox(height: 2),
                              Text(step['desc'], style: const TextStyle(fontFamily: 'Nunito', fontSize: 13, color: AppTheme.textMedium)),
                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(20), boxShadow: AppTheme.buttonShadow(AppTheme.primary)),
                    child: const Center(child: Text("Let's Play!", style: TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
