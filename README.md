# Linkoro — Number Link Flow (Numberlink)

Connect each pair of matching numbers with non-crossing paths that fill every cell. 150 levels (5×5 / 6×6 / 7×7).

## Run
```
flutter pub get
flutter run
```

## Guaranteed-solvable generation
Disjoint self-avoiding walks are carved until they fill the whole grid; any single-cell path is merged into a neighbor's endpoint. Each path's two ends become a numbered pair. Because the carve fills the grid, a complete solution exists. Validated: 240/240 boards, ~2 tries max.

## Structure
- `lib/game/link_level.dart` — path-carving generator with single-cell merge, endpoint map
- `lib/game/game_state.dart` — drag to trace pair paths, overwrite-on-cross, win when all cells filled and every pair linked
- `lib/game/board_painter.dart` — thick rounded color paths, numbered endpoint dots
- `lib/screens/` — home, level select, game, settings
- `assets/music|sounds/` — ambient tracks + link/complete SFX
- `store/` — icon, feature graphic, listing, privacy policy

## Notes
- Run `flutter create .` once, then set your own `applicationId`.
- The bundled WAV music keeps the Play Store download above 30 MB.
