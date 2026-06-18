// lib/models/game_models.dart
import 'package:flutter/material.dart';

enum GameMode { classic, chain, blitz }

enum TileState { idle, selected, correct, wrong, blasted }

enum PowerUpType { hint, shuffle, freeze, doubleScore }

class LetterTile {
  final String letter;
  final int index;
  TileState state;
  bool isBlast; // blast tile gives bonus
  Color color;

  LetterTile({
    required this.letter,
    required this.index,
    this.state = TileState.idle,
    this.isBlast = false,
    required this.color,
  });

  LetterTile copyWith({TileState? state, bool? isBlast, Color? color}) {
    return LetterTile(
      letter: letter,
      index: index,
      state: state ?? this.state,
      isBlast: isBlast ?? this.isBlast,
      color: color ?? this.color,
    );
  }
}

class PuzzleWord {
  final String original;
  final String scrambled;
  final String category;
  final int level;
  final int points;
  bool isSolved;
  int hintsUsed;
  int timeUsed; // seconds

  PuzzleWord({
    required this.original,
    required this.scrambled,
    required this.category,
    required this.level,
    required this.points,
    this.isSolved = false,
    this.hintsUsed = 0,
    this.timeUsed = 0,
  });

  int get starRating {
    if (!isSolved) return 0;
    if (hintsUsed == 0 && timeUsed < 10) return 3;
    if (hintsUsed <= 1 && timeUsed < 30) return 2;
    return 1;
  }

  int get scoreMultiplier {
    if (hintsUsed == 0) return 3;
    if (hintsUsed == 1) return 2;
    return 1;
  }
}

class LevelProgress {
  final String category;
  final int level;
  int stars; // 0-3
  int highScore;
  bool isUnlocked;

  LevelProgress({
    required this.category,
    required this.level,
    this.stars = 0,
    this.highScore = 0,
    this.isUnlocked = false,
  });

  Map<String, dynamic> toJson() => {
    'category': category,
    'level': level,
    'stars': stars,
    'highScore': highScore,
    'isUnlocked': isUnlocked,
  };

  factory LevelProgress.fromJson(Map<String, dynamic> json) => LevelProgress(
    category: json['category'],
    level: json['level'],
    stars: json['stars'] ?? 0,
    highScore: json['highScore'] ?? 0,
    isUnlocked: json['isUnlocked'] ?? false,
  );
}

class GameResult {
  final int score;
  final int stars;
  final int wordsCompleted;
  final int coinsEarned;
  final GameMode mode;
  final String? category;
  final int? level;
  final DateTime completedAt;

  GameResult({
    required this.score,
    required this.stars,
    required this.wordsCompleted,
    required this.coinsEarned,
    required this.mode,
    this.category,
    this.level,
    required this.completedAt,
  });
}

class ChainLink {
  final String word;
  final String connectingLetter;
  bool isSolved;

  ChainLink({
    required this.word,
    required this.connectingLetter,
    this.isSolved = false,
  });
}

class BlitzStats {
  int score;
  int wordsCompleted;
  int longestStreak;
  int currentStreak;
  int timeRemaining;
  bool isFrozen;

  BlitzStats({
    this.score = 0,
    this.wordsCompleted = 0,
    this.longestStreak = 0,
    this.currentStreak = 0,
    this.timeRemaining = 60,
    this.isFrozen = false,
  });
}
