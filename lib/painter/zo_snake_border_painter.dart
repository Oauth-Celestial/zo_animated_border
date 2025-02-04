import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ZoSnakeBorderPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final Color colorFrom;
  final Color colorTo;
  final Color staticBorderColor;
  final BorderRadius borderRadius;
  final double glowOpacity;

  ZoSnakeBorderPainter(
      {required this.progress,
      required this.borderWidth,
      required this.colorFrom,
      required this.colorTo,
      required this.staticBorderColor,
      required this.borderRadius,
      this.glowOpacity = 0.8});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height); // Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = borderRadius.toRRect(rect);

    // Draw static border
    final staticPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = staticBorderColor;
    canvas.drawRRect(rrect, staticPaint);

    final path = Path()..addRRect(rrect);

    final pathMetrics = path.computeMetrics().first;
    final pathLength = pathMetrics.length;

    // Adjust the animation to prevent the jump
    final animationProgress = progress % 1.0;
    final start = animationProgress * pathLength;
    final end = (start + pathLength / 4) % pathLength;

    Path extractPath;
    if (end > start) {
      extractPath = pathMetrics.extractPath(start, end);
    } else {
      extractPath = pathMetrics.extractPath(start, pathLength);
      extractPath.addPath(pathMetrics.extractPath(0, end), Offset.zero);
    }

    // Calculate gradient start and end points
    final gradientStart = pathMetrics.getTangentForOffset(start)?.position ?? Offset.zero;
    final gradientEnd = pathMetrics.getTangentForOffset((start + pathLength / 8) % pathLength)?.position ?? Offset.zero;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    paint.shader = ui.Gradient.linear(
      gradientStart,
      gradientEnd,
      [
        colorTo.withAlpha(0),
        colorTo,
        colorFrom,
      ],
      [0.0, 0.3, 1.0],
    );

    for (int i = 1; i <= glowOpacity * 10; i++) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, (10 * i).toDouble())
        ..strokeWidth = borderWidth;

      glowPaint.shader = ui.Gradient.linear(
        gradientStart,
        gradientEnd,
        [
          colorTo,
          colorFrom,
        ],
        [0.3, 1.0],
      );

      canvas.drawPath(extractPath, glowPaint);
    }
    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant ZoSnakeBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
