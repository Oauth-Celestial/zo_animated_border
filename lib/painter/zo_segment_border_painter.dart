import 'dart:math';

import 'package:flutter/material.dart';

/// A custom painter that renders [ZoSegmentBorderPainter].
class ZoSegmentBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final AnimationController progress;
  /// The border radius of the widget.
  final double borderRadius;
  /// The colors used in the border animation.
  final List<Color>? colors;
  /// The color stops for the gradient.
  final List<double>? stops;
  /// The gradient used to color the border.
  final Gradient? gradient;
  /// The length of each border segment.
  final double segmentLength;
  /// The opacity of the outer glow effect.
  final double glowOpacity;
  /// The blur radius of the glow effect.
  final double glowRadius;

  /// Creates a [ZoSegmentBorderPainter] instance.
  ZoSegmentBorderPainter({
    required this.progress,
    required this.borderRadius,
    this.colors,
    this.stops,
    this.gradient,
    required this.segmentLength,
    required this.glowOpacity,
    required this.glowRadius,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 6.0;
    final rect = Offset.zero & size;

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(borderRadius),
    );

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.white.withValues(alpha: 0.12);

    canvas.drawRRect(rrect, basePaint);

    final resolvedColors = _applyGlow(_resolveColors());
    final resolvedStops = _resolveStops(resolvedColors.length);

    final shader = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(progress.value * 2 * pi),
      colors: resolvedColors,
      stops: resolvedStops,
    ).createShader(rect);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.8
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        glowRadius,
      )
      ..blendMode = BlendMode.plus
      ..shader = shader;

    canvas.drawRRect(rrect, glowPaint);

    final mainPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = shader;

    canvas.drawRRect(rrect, mainPaint);
  }

  List<Color> _applyGlow(List<Color> base) {
    return base
        .map((c) => c.withValues(alpha: (c.a * glowOpacity).clamp(0.0, 1.0)))
        .toList();
  }

  List<Color> _resolveColors() {
    if (colors == null || colors!.isEmpty) {
      return [
        Colors.transparent,
        const Color.fromRGBO(168, 239, 255, 1),
        const Color.fromRGBO(168, 239, 255, 1),
        Colors.transparent,
      ];
    }
    return [
      Colors.transparent,
      ...colors!,
      Colors.transparent,
    ];
  }

  List<double> _resolveStops(int colorCount) {
    if (stops != null) return stops!;

    if (colorCount <= 1) return [0.0];

    return List.generate(
      colorCount,
      (index) => segmentLength * (index / (colorCount - 1)),
    );
  }

  @override
  bool shouldRepaint(covariant ZoSegmentBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.colors != colors ||
        oldDelegate.stops != stops ||
        oldDelegate.gradient != gradient ||
        oldDelegate.segmentLength != segmentLength ||
        oldDelegate.glowOpacity != glowOpacity ||
        oldDelegate.glowRadius != glowRadius;
  }
}
