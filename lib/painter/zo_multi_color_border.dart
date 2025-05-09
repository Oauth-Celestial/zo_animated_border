import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ZoMultiColorBorderPainter extends CustomPainter {
  final List<Color> colors;
  final double borderRadius;
  final double borderWidth;
  double gapLength;

  ZoMultiColorBorderPainter(
      {required this.colors,
      this.borderRadius = 8.0,
      this.borderWidth = 4.0,
      this.gapLength = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect outer =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    // final RRect inner = RRect.fromRectAndRadius(
    //   Rect.fromLTWH(
    //     borderWidth,
    //     borderWidth,
    //     size.width - 2 * borderWidth,
    //     size.height - 2 * borderWidth,
    //   ),
    //   Radius.circular(borderRadius - borderWidth),
    // );

    // Calculate the perimeter of the rounded rectangle
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

    double currentDistance = gapLength;
    for (PathMetric pathMetric in pathMetrics) {
      while (currentDistance < pathMetric.length) {
        final double remainingDistance = pathMetric.length - currentDistance;
        final double segmentLength = min(colorSegmentLength, remainingDistance);

        final int colorIndex =
            (currentDistance / colorSegmentLength).floor() % colors.length;
        paint.color = colors[colorIndex];

        final Tangent? tangent =
            pathMetric.getTangentForOffset(currentDistance);
        if (tangent != null) {
          canvas.drawPath(
            pathMetric.extractPath(
                currentDistance, currentDistance + segmentLength),
            paint,
          );
        }

        currentDistance += segmentLength + gapLength;
      }
      currentDistance = gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
