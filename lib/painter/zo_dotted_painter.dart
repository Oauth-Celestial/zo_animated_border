import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_dotted_border.dart';

/// The [ZoBorderDirection] enumeration.
enum ZoBorderDirection {
  /// The [clockwise] property.
  clockwise,
  /// The [anticlockwise] property.
  anticlockwise,
}

/// A custom painter that renders [ZoDottedBorderPainter].
class ZoDottedBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [dashLength] property.
  final double dashLength;
  /// The length of the gap.
  final double gapLength;
  /// Optional custom stroke width for the border.
  final double strokeWidth;
  /// The primary color of the border animation.
  final Color color;
  /// The [animationSpeed] property.
  final double animationSpeed;
  /// The gradient used to color the border.
  final Gradient? gradient;
  /// The [borderStyle] property.
  final BorderStyleType borderStyle;
  /// The direction of the animation.
  final ZoBorderDirection direction;

  /// Creates a [ZoDottedBorderPainter] instance.
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
    if (size.isEmpty) return;

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Rect rect = Offset.zero & size;
    if (borderStyle == BorderStyleType.gradient) {
      paint.shader = gradient?.createShader(rect);
    } else {
      paint.color = color;
    }

    // Rounded rectangle path
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      ));

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    for (final pathMetric in metrics) {
      final totalLength = pathMetric.length;
      if (totalLength == 0) continue;

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
  bool shouldRepaint(covariant ZoDottedBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.animationSpeed != animationSpeed ||
        oldDelegate.color != color ||
        oldDelegate.gradient != gradient ||
        oldDelegate.borderStyle != borderStyle ||
        oldDelegate.direction != direction;
  }
}

