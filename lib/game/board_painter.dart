// lib/game/board_painter.dart
import 'package:flutter/material.dart';
import 'game_state.dart';
import '../utils/constants.dart';

class BoardPainter extends CustomPainter {
  final GameState st;
  BoardPainter(this.st);

  @override
  void paint(Canvas canvas, Size size) {
    final n = st.n;
    final cell = size.width / n;

    // cells
    for (int i = 0; i < n * n; i++) {
      final r = i ~/ n, c = i % n;
      final rect = Rect.fromLTWH(c * cell + 1.5, r * cell + 1.5,
          cell - 3, cell - 3);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          Paint()..color = kCell);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          Paint()
            ..color = kCellEdge
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);
    }

    // paths (thick rounded lines per pair)
    st.paths.forEach((pid, path) {
      if (path.length < 2) return;
      final color = kPairColors[pid % kPairColors.length];
      Offset ctr(int i) =>
          Offset((i % n) * cell + cell / 2, (i ~/ n) * cell + cell / 2);
      final p = Path()..moveTo(ctr(path.first).dx, ctr(path.first).dy);
      for (int k = 1; k < path.length; k++) {
        p.lineTo(ctr(path[k]).dx, ctr(path[k]).dy);
      }
      canvas.drawPath(
          p,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = cell * 0.32
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round);
    });

    // endpoints (filled dots with pair number)
    st.level.endpoints.forEach((cellIdx, pid) {
      final r = cellIdx ~/ n, c = cellIdx % n;
      final center = Offset(c * cell + cell / 2, r * cell + cell / 2);
      final color = kPairColors[pid % kPairColors.length];
      final linked = st.pairLinked(pid);
      if (linked) {
        canvas.drawCircle(
            center,
            cell * 0.38,
            Paint()
              ..color = color.withOpacity(0.4)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));
      }
      canvas.drawCircle(center, cell * 0.30, Paint()..color = color);
      canvas.drawCircle(center, cell * 0.30,
          Paint()
            ..color = Colors.black.withOpacity(0.25)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
      final tp = TextPainter(
        text: TextSpan(
            text: '${pid + 1}',
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: cell * 0.30,
                fontWeight: FontWeight.w900)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
    });
  }

  @override
  bool shouldRepaint(BoardPainter old) => true;
}
