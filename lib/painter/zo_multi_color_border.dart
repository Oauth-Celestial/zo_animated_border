import 'dart:ui';
import 'package:flutter/material.dart';

class ZoMultiColorBorderPainter extends CustomPainter {
  final List<Color> colors;
  final double borderRadius;
  final double borderWidth;
  final double gapLength;
  final Animation<double>? progress;

  ZoMultiColorBorderPainter({
    required this.colors,
    this.borderRadius = 8.0,
    this.borderWidth = 4.0,
    this.gapLength = 0,
    this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect outer =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    final Path path = Path()..addRRect(outer);
    final PathMetrics pathMetrics = path.computeMetrics(forceClosed: true);

    // Get total path length
    final double totalLength =
        pathMetrics.fold(0.0, (sum, m) => sum + m.length);

    final double colorSegmentLength =
        (totalLength - (gapLength * colors.length)) / colors.length;

    final double startOffset = (progress?.value ?? 0) * totalLength;

    for (final pathMetric in path.computeMetrics(forceClosed: true)) {
      double currentDistance = startOffset;

      for (int i = 0; i < colors.length; i++) {
        double segmentStart = currentDistance % pathMetric.length;
        double segmentEnd = segmentStart + colorSegmentLength;

        paint.color = colors[i];

        if (segmentEnd > pathMetric.length) {
          // Wrap around
          final firstPart =
              pathMetric.extractPath(segmentStart, pathMetric.length);
          final secondPart =
              pathMetric.extractPath(0, segmentEnd - pathMetric.length);
          canvas.drawPath(firstPart, paint);
          canvas.drawPath(secondPart, paint);
        } else {
          final segment = pathMetric.extractPath(segmentStart, segmentEnd);
          canvas.drawPath(segment, paint);
        }

        currentDistance += colorSegmentLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant ZoMultiColorBorderPainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.progress != progress;
  }
}
