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
  /// The thickness of the border stroke.
  final double strokeWidth;

  final List<Color> _gradientColors;

  /// Creates a [ZoPsychoBorderPainter] instance.
  ZoPsychoBorderPainter({
    required this.progress,
    required this.ringCount,
    required this.colors,
    required this.maxSpread,
    required this.borderRadius,
    this.strokeWidth = 2.5,
  })  : _gradientColors =
            colors.isNotEmpty ? [...colors, colors.first] : const [],
        super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || colors.isEmpty) return;

    final baseRect = Offset.zero & size;
    final rrect = borderRadius.toRRect(baseRect);

    final progressVal = progress.value;
    final rotation = progressVal * 2 * math.pi;

    final gradient = SweepGradient(
      center: Alignment.center,
      colors: _gradientColors,
      transform: GradientRotation(rotation),
    );

    final shader = gradient.createShader(baseRect);

    final glowPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4.0);

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

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

      final shiftedRRect = rrect.shift(offset);
      canvas.drawRRect(shiftedRRect, glowPaint);
      canvas.drawRRect(shiftedRRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ZoPsychoBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringCount != ringCount ||
        oldDelegate.maxSpread != maxSpread ||
        oldDelegate.colors != colors ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
