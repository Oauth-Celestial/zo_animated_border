import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_dotted_border.dart';

class ZoDottedBorderPainter extends CustomPainter {
  final Animation<double> progress;
  final double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Color color;
  double? animationSpeed;
  Gradient? gradient;
  final BorderStyleType borderStyle;

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

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius)));

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double totalLength = pathMetric.length;
      double phase = (progress.value * animationSpeed! * totalLength) %
          (dashLength + gapLength);

      double distance = phase;
      while (distance < totalLength) {
        double nextDistance = min(distance + dashLength, totalLength);
        if (nextDistance > 0) {
          Path extractPath = pathMetric.extractPath(distance, nextDistance);
          // Tangent? tangent = pathMetric.getTangentForOffset(nextDistance);
          // if (tangent != null) {
          //   Path path = Path();
          //   path.addOval(Rect.fromCenter(
          //       center: tangent.position, width: 10, height: 10));
          //   canvas.drawPath(path, paint);
          // }
          canvas.drawPath(extractPath, paint);
        } else {}
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
