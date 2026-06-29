// lib/game/link_level.dart
import 'dart:math';

/// Numberlink ("Linkoro"). Pairs of numbered endpoints must be connected by
/// non-crossing paths that together fill every cell. Generation carves real
/// disjoint self-avoiding paths covering the whole grid; each path's two ends
/// become a numbered pair. Because the carve fills the grid, a full solution
/// exists. (We don't enforce uniqueness — any fill that links all pairs and
/// covers the grid wins.)
class LinkLevel {
  final int index;
  final int n;
  final String difficulty;
  final int pairCount;
  final Map<int, int> endpoints;  // cell -> pair id (only endpoints)
  final List<List<int>> solution; // solution paths (for par/hints)
  LinkLevel({
    required this.index,
    required this.n,
    required this.difficulty,
    required this.pairCount,
    required this.endpoints,
    required this.solution,
  });
}

class LevelGenerator {
  static LinkLevel generate(int levelIndex) {
    int n;
    String difficulty;
    if (levelIndex < 50) {
      n = 5; difficulty = 'Easy';
    } else if (levelIndex < 100) {
      n = 6; difficulty = 'Medium';
    } else {
      n = 7; difficulty = 'Hard';
    }
    final rng = Random(levelIndex * 977 + levelIndex * 19 + 7);
    for (int t = 0; t < 300; t++) {
      final res = _build(levelIndex, n, difficulty, Random(rng.nextInt(1 << 31)));
      if (res != null) return res;
    }
    // trivial fallback: single straight pair
    return LinkLevel(
      index: levelIndex, n: n, difficulty: difficulty, pairCount: 1,
      endpoints: {0: 0, n - 1: 0},
      solution: [[for (int c = 0; c < n; c++) c]],
    );
  }

  static List<int> _nbrs(int i, int n) {
    final r = i ~/ n, c = i % n;
    return [
      if (r > 0) i - n,
      if (r < n - 1) i + n,
      if (c > 0) i - 1,
      if (c < n - 1) i + 1,
    ];
  }

  static LinkLevel? _build(int index, int n, String diff, Random rng) {
    final free = <int>{for (int i = 0; i < n * n; i++) i};
    final paths = <List<int>>[];
    while (free.isNotEmpty) {
      final start = free.elementAt(rng.nextInt(free.length));
      final path = <int>[start];
      free.remove(start);
      while (true) {
        final opts = _nbrs(path.last, n).where(free.contains).toList();
        if (opts.isEmpty) break;
        if (path.length >= 2 && rng.nextDouble() < 0.15) break;
        final nxt = opts[rng.nextInt(opts.length)];
        path.add(nxt);
        free.remove(nxt);
      }
      paths.add(path);
    }

    // merge single-cell paths into a touching path's endpoint
    bool changed = true;
    while (changed) {
      changed = false;
      final cellMap = <int, int>{};
      for (int pi = 0; pi < paths.length; pi++) {
        for (final c in paths[pi]) cellMap[c] = pi;
      }
      final singles = [
        for (int pi = 0; pi < paths.length; pi++)
          if (paths[pi].length == 1) pi
      ];
      for (final pi in singles) {
        final cell = paths[pi][0];
        for (final nb in _nbrs(cell, n)) {
          final pj = cellMap[nb];
          if (pj == null || pj == pi) continue;
          if (paths[pj].first == nb) {
            paths[pj].insert(0, cell);
          } else if (paths[pj].last == nb) {
            paths[pj].add(cell);
          } else {
            continue;
          }
          paths[pi] = [];
          changed = true;
          break;
        }
      }
      paths.removeWhere((p) => p.isEmpty);
    }

    if (paths.any((p) => p.length == 1)) return null;
    if (paths.length < 2 || paths.length > n + 3) return null;
    if (paths.length > kMaxPairs) return null;

    final endpoints = <int, int>{};
    for (int pi = 0; pi < paths.length; pi++) {
      endpoints[paths[pi].first] = pi;
      endpoints[paths[pi].last] = pi;
    }
    return LinkLevel(
      index: index,
      n: n,
      difficulty: diff,
      pairCount: paths.length,
      endpoints: endpoints,
      solution: paths,
    );
  }

  static const kMaxPairs = 10;
}
