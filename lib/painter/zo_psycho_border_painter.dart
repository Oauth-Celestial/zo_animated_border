import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A custom painter that renders [ZoPsychoBorderPainter].
class ZoPsychoBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The number of concentric rings.
  final int ringCount;
  /// The colors used in the border animation.
  final List<Color> colors;
  /// The maximum spread distance between rings.
  final double maxSpread;
  /// The border radius of the widget.
  final BorderRadius borderRadius;

  final List<Color> _gradientColors;

  /// Creates a [ZoPsychoBorderPainter] instance.
  ZoPsychoBorderPainter({
    required this.progress,
    required this.ringCount,
    required this.colors,
    required this.maxSpread,
    required this.borderRadius,
  })  : _gradientColors = colors.isNotEmpty ? [...colors, colors.first] : const [],
        super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || colors.isEmpty) return;

    final rect =
        (Offset.zero & size).deflate(maxSpread + 1.0); // Prevent clipping
    if (rect.isEmpty) return;
    final rrect = borderRadius.toRRect(rect);

    final progressVal = progress.value;
    final rotation = progressVal * 2 * math.pi;

    final gradient = SweepGradient(
      colors: _gradientColors,
      transform: GradientRotation(rotation),
    );

    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // spread between the rings
    double currentOffset = math.sin(progressVal * 2 * math.pi) * maxSpread;
    double axisRotation = progressVal * math.pi;

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

