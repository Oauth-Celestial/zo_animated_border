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
    this.borderRadius = 20,
    this.borderWidth = 4.0,
    this.gapLength = 20,
    this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Hardcoded segments and gap
    List<Color> c = [Colors.yellow, Colors.red, Colors.blue, Colors.green];
    int segments = c.length;
    double gapLength = 8.0;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(20));

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWidth
      ..color = Colors.black;

    Path path = Path()..addRRect(rRect);

    for (PathMetric p in path.computeMetrics()) {
      double totalLength = p.length;
      double segmentLength = (totalLength - gapLength * segments) / segments;

      double progressOffset = totalLength * (progress?.value ?? 0);

      for (int i = 0; i < segments; i++) {
        paint.color = c[i];
        double start = (segmentLength + gapLength) * i + progressOffset;
        double end = start + segmentLength;

        start = start % totalLength;
        end = end % totalLength;

        Path drawPath;
        if (end > start) {
          drawPath = p.extractPath(start, end);
        } else {
          drawPath = Path()
            ..addPath(p.extractPath(start, totalLength), Offset.zero)
            ..addPath(p.extractPath(0, end), Offset.zero);
        }

        canvas.drawPath(drawPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ZoMultiColorBorderPainter oldDelegate) {
    return true;
  }
}



  // final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // final RRect outer =
    //     RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // final Paint paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = borderWidth
    //   ..strokeCap = StrokeCap.round;

    // final Path path = Path()..addRRect(outer);
    // final PathMetrics pathMetrics = path.computeMetrics(forceClosed: true);

    // Get total path length
    // final double totalLength =
    //     pathMetrics.fold(0.0, (sum, m) => sum + m.length);

    // final double colorSegmentLength =
    //     (totalLength - (gapLength * colors.length)) / colors.length;

    // final double startOffset = (progress?.value ?? 0) * totalLength;

    // for (final pathMetric in path.computeMetrics(forceClosed: true)) {
    //   double currentDistance = startOffset;

    //   for (int i = 0; i < colors.length; i++) {
    //     double segmentStart = currentDistance % pathMetric.length;
    //     double segmentEnd = segmentStart + colorSegmentLength;

    //     paint.color = colors[i];

    //     if (segmentEnd > pathMetric.length) {
    //       // Wrap around
    //       final firstPart =
    //           pathMetric.extractPath(segmentStart, pathMetric.length);
    //       final secondPart =
    //           pathMetric.extractPath(0, segmentEnd - pathMetric.length);
    //       canvas.drawPath(firstPart, paint);
    //       canvas.drawPath(secondPart, paint);
    //     } else {
    //       final segment = pathMetric.extractPath(segmentStart, segmentEnd);
    //       canvas.drawPath(segment, paint);
    //     }

    //     currentDistance += colorSegmentLength + gapLength;
    //   }
    // }