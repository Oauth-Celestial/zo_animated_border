import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ZoDualBorderPainter extends CustomPainter {
  final Animation<double> progress;
  final double borderWidth;
  final Color firstBorderColor;
  final Color secondBorderColor;
  final Color staticBorderColor;
  final BorderRadius borderRadius;
  final double glowOpacity;

  ZoDualBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.firstBorderColor,
    required this.secondBorderColor,
    required this.staticBorderColor,
    required this.borderRadius,
    this.glowOpacity = 0.1,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    final staticPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = staticBorderColor;
    canvas.drawRRect(rrect, staticPaint);

    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final length = metric.length;

    void drawAnimatedBorder({required double offset, required Color color}) {
      final start = offset * length;
      final end = (start + length / 4) % length;

      Path segment;
      if (end > start) {
        segment = metric.extractPath(start, end);
      } else {
        segment = Path()
          ..addPath(metric.extractPath(start, length), Offset.zero)
          ..addPath(metric.extractPath(0, end), Offset.zero);
      }

      final path1 = metric.getTangentForOffset(start)?.position ?? Offset.zero;
      final path2 =
          metric.getTangentForOffset((start + length / 8) % length)?.position ??
              Offset.zero;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..shader = ui.Gradient.linear(
          path1,
          path2,
          [color, color, color],
          [0.0, 0.3, 1.0],
        );

      canvas.drawPath(segment, paint);

      for (int i = 1; i <= glowOpacity * 10; i++) {
        canvas.drawPath(
          segment,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth
            ..color = color
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0 * i),
        );
      }
    }

    drawAnimatedBorder(offset: progress.value % 1.0, color: firstBorderColor);
    drawAnimatedBorder(
      offset: (progress.value + 0.5) % 1.0,
      color: secondBorderColor,
    );
  }

  @override
  bool shouldRepaint(covariant ZoDualBorderPainter oldDelegate) => true;
}
