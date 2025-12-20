import 'dart:math';

import 'package:flutter/material.dart';

class ZoHandDrawnPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double blur;
  final double strokeWidth;

  ZoHandDrawnPainter(
      {required this.progress,
      this.color = Colors.amber,
      this.blur = 5,
      this.strokeWidth = 8});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = min(size.width, size.height) / 2.8;

    final path = Path();

    for (double i = 0; i <= 2 * pi; i += 0.05) {
      double noise = sin(i * 5 + progress * 2 * pi) * 1.5;
      noise += cos(i * 3 - progress * pi) * 1.0;
      noise += sin(i * 12) * 0.5;

      double r = baseRadius + noise;
      double x = center.dx + r * cos(i);
      double y = center.dy + r * sin(i);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Inner Glow (Medium blur)
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
            .withValues(alpha: 0.9) // Bright white core makes it pop
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / 4
        ..strokeCap = StrokeCap.round,
    );

    // Main color tint over the core
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant ZoHandDrawnPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
