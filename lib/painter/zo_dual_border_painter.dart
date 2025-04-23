import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ZoDualBorderPainter extends CustomPainter {
  final Animation<double> progress;
  final double borderWidth;
  final Color firstBorderColor;
  final Color secondBorderColor;
  final Color staticBorderColor;

  final BorderRadius borderRadius;

  final double glowOpacity;

  ZoDualBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.firstBorderColor,
    required this.secondBorderColor,
    required this.staticBorderColor,
    required this.borderRadius,
    this.glowOpacity = 0.1,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
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

    // Calculate the primary animation path
    final animationProgress = progress.value % 1.0;
    final start = animationProgress * pathLength;
    final end = (start + pathLength / 4) % pathLength;

    Path extractPath;
    if (end > start) {
      extractPath = pathMetrics.extractPath(start, end);
    } else {
      extractPath = pathMetrics.extractPath(start, pathLength);
      extractPath.addPath(pathMetrics.extractPath(0, end), Offset.zero);
    }

    // Calculate gradient for primary path
    final gradientStart =
        pathMetrics.getTangentForOffset(start)?.position ?? Offset.zero;
    final gradientEnd = pathMetrics
            .getTangentForOffset((start + pathLength / 8) % pathLength)
            ?.position ??
        Offset.zero;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    paint.shader = ui.Gradient.linear(
      gradientStart,
      gradientEnd,
      [
        firstBorderColor,
        firstBorderColor,
        firstBorderColor,
      ],
      [0.0, 0.3, 1.0],
    );

    canvas.drawPath(extractPath, paint);
    for (int i = 1; i <= glowOpacity * 10; i++) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, (5 * i).toDouble())
        ..color = firstBorderColor
        ..strokeWidth = borderWidth;
      canvas.drawPath(extractPath, glowPaint);
    }

    // Calculate the mirrored animation path
    final mirroredProgress = (progress.value + 0.5) % 1.0; // Offset by 50%
    final mirroredStart = mirroredProgress * pathLength;
    final mirroredEnd = (mirroredStart + pathLength / 4) % pathLength;

    Path mirroredPath;
    if (mirroredEnd > mirroredStart) {
      mirroredPath = pathMetrics.extractPath(mirroredStart, mirroredEnd);
    } else {
      mirroredPath = pathMetrics.extractPath(mirroredStart, pathLength);
      mirroredPath.addPath(
          pathMetrics.extractPath(0, mirroredEnd), Offset.zero);
    }

    // Calculate gradient for mirrored path
    final mirroredGradientStart =
        pathMetrics.getTangentForOffset(mirroredStart)?.position ?? Offset.zero;
    final mirroredGradientEnd = pathMetrics
            .getTangentForOffset((mirroredStart + pathLength / 8) % pathLength)
            ?.position ??
        Offset.zero;

    final mirroredPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    mirroredPaint.shader = ui.Gradient.linear(
      mirroredGradientStart,
      mirroredGradientEnd,
      [
        secondBorderColor,
        secondBorderColor,
        secondBorderColor,
      ],
      [0.0, 0.3, 1.0],
    );

    canvas.drawPath(mirroredPath, mirroredPaint);
// add Glow to the second  border
    for (int i = 1; i <= glowOpacity * 10; i++) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, (5 * i).toDouble())
        ..color = secondBorderColor
        ..strokeWidth = borderWidth;
      canvas.drawPath(mirroredPath, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ZoDualBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
