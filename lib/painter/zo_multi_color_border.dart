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
    int segments = colors.length;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

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
        paint.color = colors[i];
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
    return oldDelegate.colors != colors ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.progress != progress;
  }
}
