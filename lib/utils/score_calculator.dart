// lib/utils/score_calculator.dart

class ScoreCalculator {
  static int calculateWordScore({
    required String word,
    required int hintsUsed,
    required int timeUsed,
    required bool hasBlastTile,
    int streak = 1,
  }) {
    // Base: 10 pts per letter
    int base = word.length * 10;

    // No-hint bonus
    if (hintsUsed == 0) base = (base * 1.5).round();

    // Speed bonus
    if (timeUsed < 5) base += 50;
    else if (timeUsed < 10) base += 30;
    else if (timeUsed < 20) base += 10;

    // Blast tile bonus
    if (hasBlastTile) base = (base * 2).round();

    // Streak multiplier
    final streakMultiplier = 1.0 + ((streak - 1) * 0.1).clamp(0, 1.0);
    base = (base * streakMultiplier).round();

    return base;
  }

  static int coinsFromStars(int stars) {
    switch (stars) {
      case 3: return 15;
      case 2: return 10;
      case 1: return 5;
      default: return 0;
    }
  }

  static int calculateBlitzScore({
    required String word,
    required int streak,
    bool isFrozen = false,
  }) {
    int base = word.length * 15;
    if (streak >= 5) base = (base * 2.0).round();
    else if (streak >= 3) base = (base * 1.5).round();
    return base;
  }

  static String streakLabel(int streak) {
    if (streak >= 10) return '🔥 LEGENDARY!';
    if (streak >= 7) return '⚡ ON FIRE!';
    if (streak >= 5) return '💥 COMBO x$streak!';
    if (streak >= 3) return '✨ STREAK x$streak!';
    return '';
  }
}
