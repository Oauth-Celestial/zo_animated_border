import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_dotted_border.dart';

enum ZoBorderDirection {
  clockwise,
  anticlockwise,
}

class ZoDottedBorderPainter extends CustomPainter {
  final Animation<double> progress;
  final double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Color color;
  final double animationSpeed;
  final Gradient? gradient;
  final BorderStyleType borderStyle;
  final ZoBorderDirection direction;

  ZoDottedBorderPainter({
    required this.progress,
    required this.borderRadius,
    this.dashLength = 10,
    this.gapLength = 5,
    this.strokeWidth = 3,
    this.animationSpeed = 0.4,
    this.color = Colors.black,
    this.gradient,
    required this.borderStyle,
    this.direction = ZoBorderDirection.clockwise,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (borderStyle == BorderStyleType.gradient) {
      final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
      paint.shader = gradient?.createShader(rect);
    } else {
      paint.color = color;
    }

    // Rounded rectangle path
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    for (final pathMetric in path.computeMetrics()) {
      final totalLength = pathMetric.length;

      // Direction multiplier: +1 for clockwise, -1 for anticlockwise
      final double directionMultiplier =
          direction == ZoBorderDirection.anticlockwise ? 1.0 : -1.0;

      // Smooth phase offset
      final double phase = (progress.value *
              animationSpeed *
              totalLength *
              directionMultiplier) %
          (dashLength + gapLength);

      double distance = -phase;
      while (distance < totalLength) {
        final double start = max(distance, 0);
        final double end = min(distance + dashLength, totalLength);
        if (end > start) {
          final Path extractPath = pathMetric.extractPath(start, end);
          canvas.drawPath(extractPath, paint);
        }
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
