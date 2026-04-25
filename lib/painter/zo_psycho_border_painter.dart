import 'dart:math' as math;
import 'package:flutter/material.dart';

class ZoPsychoBorderPainter extends CustomPainter {
  final double progress;
  final int ringCount;
  final List<Color> colors;
  final double maxSpread;
  final BorderRadius borderRadius;

  ZoPsychoBorderPainter({
    required this.progress,
    required this.ringCount,
    required this.colors,
    required this.maxSpread,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect =
        (Offset.zero & size).deflate(maxSpread + 1.0); // Prevent clipping
    if (rect.isEmpty) return;
    final rrect = borderRadius.toRRect(rect);

    final rotation = progress * 2 * math.pi;

    final gradientColors = [...colors, colors.first];

    final gradient = SweepGradient(
      colors: gradientColors,
      transform: GradientRotation(rotation),
    );

    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // spread between the rings
    double currentOffset = math.sin(progress * 2 * math.pi) * maxSpread;
    double axisRotation = progress * math.pi;

    for (int i = 0; i < ringCount; i++) {
      // Divide 360 degrees (2 * pi) equally among the requested number of rings
      double phaseShift = (2 * math.pi / ringCount) * i;

      Offset offset = Offset(
        math.cos(axisRotation + phaseShift) * currentOffset,
        math.sin(axisRotation + phaseShift) * currentOffset,
      );

      canvas.drawRRect(rrect.shift(offset), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ZoPsychoBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringCount != ringCount ||
        oldDelegate.maxSpread != maxSpread ||
        oldDelegate.colors != colors ||
        oldDelegate.borderRadius != borderRadius;
  }
}
