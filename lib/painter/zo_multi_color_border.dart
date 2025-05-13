import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ZoMultiColorBorderPainter extends CustomPainter {
  final List<Color> colors;
  final double borderRadius;
  final double borderWidth;
  double gapLength;
  Animation<double>? progress;

  ZoMultiColorBorderPainter(
      {required this.colors,
      this.borderRadius = 8.0,
      this.borderWidth = 4.0,
      this.progress,
      this.gapLength = 0})
      : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect outer =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final double perimeter = 2 * (size.width + size.height) -
        8 * borderRadius +
        2 * pi * borderRadius;
    final double colorSegmentLength = perimeter / colors.length;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    Path path = Path()..addRRect(outer);
    PathMetrics pathMetrics = path.computeMetrics();

    // Calculate the starting offset based on animation value
    // This creates a seamless loop when animation completes
    double startOffset = perimeter * (progress?.value ?? 0);

    for (PathMetric pathMetric in pathMetrics) {
      double currentDistance = startOffset;

      // Draw the full loop (perimeter) starting from startOffset
      for (int i = 0; i < colors.length; i++) {
        final double segmentStart = currentDistance % perimeter;
        double segmentEnd = segmentStart + colorSegmentLength;

        // Wrap around if needed
        if (segmentEnd > perimeter) {
          // Draw first part
          paint.color = colors[i];
          canvas.drawPath(
            pathMetric.extractPath(segmentStart, perimeter),
            paint,
          );

          // Draw remaining part from beginning
          canvas.drawPath(
            pathMetric.extractPath(0, segmentEnd - perimeter),
            paint,
          );
        } else {
          paint.color = colors[i];
          canvas.drawPath(
            pathMetric.extractPath(segmentStart, segmentEnd),
            paint,
          );
        }

        currentDistance += colorSegmentLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
