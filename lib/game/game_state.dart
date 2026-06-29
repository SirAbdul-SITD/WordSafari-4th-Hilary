// lib/game/game_state.dart
import 'package:flutter/material.dart';
import 'link_level.dart';
import '../utils/preferences.dart';
import '../utils/audio_manager.dart';

/// The player drags from an endpoint to trace a path of its pair color.
/// cellPair[i] = pair id occupying cell i (-1 none). Drawing from an endpoint
/// lays its color; crossing another pair's cells overwrites them (that pair's
/// path is then broken and must be redrawn). Win when every cell is filled and
/// each pair's two endpoints are connected by a contiguous same-color path.
class GameState extends ChangeNotifier {
  late LinkLevel level;
  late List<int> cellPair;        // -1 empty, else pair id
  final Map<int, List<int>> paths = {}; // pair id -> current drawn path
  int activePair = -1;
  int moves = 0;
  bool isComplete = false;
  int stars = 0;
  int currentLevelIndex = 0;
  bool initialized = false;

  int get n => level.n;

  void loadLevel(int index) {
    currentLevelIndex = index;
    level = LevelGenerator.generate(index);
    cellPair = List<int>.filled(n * n, -1);
    paths.clear();
    // place endpoints as occupied by their own pair
    level.endpoints.forEach((cell, pair) {
      cellPair[cell] = -1; // endpoints aren't "filled path" until connected
    });
    activePair = -1;
    moves = 0;
    isComplete = false;
    stars = 0;
    initialized = true;
    notifyListeners();
  }

  bool isEndpoint(int cell) => level.endpoints.containsKey(cell);
  int? endpointPair(int cell) => level.endpoints[cell];

  List<int> _nbrs(int i) {
    final r = i ~/ n, c = i % n;
    return [
      if (r > 0) i - n,
      if (r < n - 1) i + n,
      if (c > 0) i - 1,
      if (c < n - 1) i + 1,
    ];
  }

  void beginAt(int cell) {
    if (isComplete) return;
    final ep = level.endpoints[cell];
    if (ep != null) {
      // start a fresh path for this pair from this endpoint
      _clearPair(ep);
      activePair = ep;
      paths[ep] = [cell];
      cellPair[cell] = ep;
      notifyListeners();
    } else if (cellPair[cell] != -1) {
      // continue an existing pair from where we grab (truncate to that cell)
      final pid = cellPair[cell];
      final path = paths[pid];
      if (path != null) {
        final idx = path.indexOf(cell);
        if (idx >= 0) {
          // truncate after this cell
          for (int k = idx + 1; k < path.length; k++) {
            if (!isEndpoint(path[k])) cellPair[path[k]] = -1;
            else cellPair[path[k]] = -1;
          }
          path.removeRange(idx + 1, path.length);
          activePair = pid;
          notifyListeners();
        }
      }
    }
  }

  void extendTo(int cell) {
    if (isComplete || activePair == -1) return;
    final path = paths[activePair];
    if (path == null || path.isEmpty) return;
    // backtrack
    if (path.length >= 2 && cell == path[path.length - 2]) {
      final removed = path.removeLast();
      if (!isEndpoint(removed)) cellPair[removed] = -1;
      else cellPair[removed] = -1;
      notifyListeners();
      return;
    }
    if (!_nbrs(path.last).contains(cell)) return;
    if (path.contains(cell)) return;
    // can't pass through the OTHER pair's endpoint
    final ep = level.endpoints[cell];
    if (ep != null && ep != activePair) return;
    // overwrite any other pair occupying the cell
    final occ = cellPair[cell];
    if (occ != -1 && occ != activePair) {
      _clearPair(occ);
    }
    path.add(cell);
    cellPair[cell] = activePair;
    AudioManager.instance.playLink();
    // reaching the matching endpoint completes this pair's path
    _check();
    notifyListeners();
  }

  void endDrag() {
    activePair = -1;
    moves++;
    notifyListeners();
  }

  void _clearPair(int pid) {
    final path = paths[pid];
    if (path != null) {
      for (final c in path) {
        if (cellPair[c] == pid) cellPair[c] = -1;
      }
    }
    paths.remove(pid);
  }

  /// Is a pair fully linked: path from one endpoint to the other?
  bool pairLinked(int pid) {
    final path = paths[pid];
    if (path == null || path.length < 2) return false;
    final a = path.first, b = path.last;
    return isEndpoint(a) &&
        isEndpoint(b) &&
        level.endpoints[a] == pid &&
        level.endpoints[b] == pid;
  }

  int get linkedCount {
    int n2 = 0;
    for (int p = 0; p < level.pairCount; p++) {
      if (pairLinked(p)) n2++;
    }
    return n2;
  }

  int get filledCount => cellPair.where((c) => c != -1).length;

  void _check() {
    // all cells filled?
    for (final c in cellPair) {
      if (c == -1) return;
    }
    // all pairs linked?
    for (int p = 0; p < level.pairCount; p++) {
      if (!pairLinked(p)) return;
    }
    isComplete = true;
    stars = _calcStars();
    AudioManager.instance.playComplete();
    Preferences.instance.saveLevelResult(currentLevelIndex, stars);
  }

  int _calcStars() {
    final par = level.pairCount; // ideal: one continuous draw per pair
    if (moves <= par + 1) return 3;
    if (moves <= par * 3) return 2;
    return 1;
  }

  void restartLevel() {
    cellPair = List<int>.filled(n * n, -1);
    paths.clear();
    activePair = -1;
    moves = 0;
    isComplete = false;
    stars = 0;
    notifyListeners();
  }

  void nextLevel() {
    if (currentLevelIndex < 149) loadLevel(currentLevelIndex + 1);
  }
}
