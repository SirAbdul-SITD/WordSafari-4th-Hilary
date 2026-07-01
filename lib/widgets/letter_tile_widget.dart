// lib/widgets/letter_tile_widget.dart
import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';

class LetterTileWidget extends StatefulWidget {
  final LetterTile tile;
  final VoidCallback? onTap;
  final double size;
  final bool isAnswer;

  const LetterTileWidget({
    super.key,
    required this.tile,
    this.onTap,
    this.size = 56,
    this.isAnswer = false,
  });

  @override
  State<LetterTileWidget> createState() => _LetterTileWidgetState();
}

class _LetterTileWidgetState extends State<LetterTileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _bgColor {
    switch (widget.tile.state) {
      case TileState.correct:
        return AppTheme.green;
      case TileState.wrong:
        return AppTheme.red;
      case TileState.selected:
        return widget.tile.color.withOpacity(0.85);
      default:
        return widget.tile.color;
    }
  }

  Color get _shadowColor {
    switch (widget.tile.state) {
      case TileState.correct: return AppTheme.green;
      case TileState.wrong: return AppTheme.red;
      default: return widget.tile.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.tile.state == TileState.selected;

    return GestureDetector(
      onTapDown: (_) { if (!isDisabled) _ctrl.forward(); },
      onTapUp: (_) {
        _ctrl.reverse();
        if (!isDisabled) widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: isDisabled
                ? AppTheme.textLight.withOpacity(0.3)
                : _bgColor,
            borderRadius: BorderRadius.circular(widget.size * 0.22),
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: _shadowColor.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(-1, -1),
                    ),
                  ],
            border: Border.all(
              color: isDisabled
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Letter
              Text(
                widget.tile.letter.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: widget.size * 0.45,
                  fontWeight: FontWeight.w700,
                  color: isDisabled ? AppTheme.textLight : Colors.white,
                  shadows: isDisabled
                      ? []
                      : [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
              ),
              // Blast indicator
              if (widget.tile.isBlast && widget.tile.state == TileState.idle)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accent.withOpacity(0.8),
                          blurRadius: 4,
                        ),
                      ],
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

// Empty slot widget
class AnswerSlotWidget extends StatelessWidget {
  final LetterTile? tile;
  final VoidCallback? onTap;
  final double size;
  final int index;
  final String targetLetter; // for hint highlighting

  const AnswerSlotWidget({
    super.key,
    this.tile,
    this.onTap,
    this.size = 52,
    required this.index,
    this.targetLetter = '',
  });

  @override
  Widget build(BuildContext context) {
    if (tile != null) {
      return LetterTileWidget(
        tile: tile!,
        onTap: onTap,
        size: size,
        isAnswer: true,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size * 0.22),
          border: Border.all(
            color: AppTheme.primary.withOpacity(0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: size * 0.35,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
