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
  /// The spread distance of the glow effect.
  final double glowSpread;

  final List<Color> _resolvedColors;
  final List<double> _resolvedStops;

  /// Creates a [ZoSegmentBorderPainter] instance.
  ZoSegmentBorderPainter({
    required this.progress,
    required this.borderRadius,
    this.colors,
    this.stops,
    this.gradient,
    required this.segmentLength,
    required this.glowOpacity,
    required this.glowSpread,
  })  : _resolvedColors = _applyGlowStatic(_resolveColorsStatic(colors), glowOpacity),
        _resolvedStops = _resolveStopsStatic(stops, _resolveColorsStatic(colors).length, segmentLength),
        super(repaint: progress);

  static List<Color> _applyGlowStatic(List<Color> base, double opacity) {
    return base
        .map((c) => c.withValues(alpha: (c.a * opacity).clamp(0.0, 1.0)))
        .toList();
  }

  static List<Color> _resolveColorsStatic(List<Color>? colors) {
    if (colors == null || colors.isEmpty) {
      return const [
        Colors.transparent,
        Color.fromRGBO(168, 239, 255, 1),
        Color.fromRGBO(168, 239, 255, 1),
        Colors.transparent,
      ];
    }
    return [
      Colors.transparent,
      ...colors,
      Colors.transparent,
    ];
  }

  static List<double> _resolveStopsStatic(List<double>? stops, int colorCount, double segLength) {
    if (stops != null) return stops;
    if (colorCount <= 1) return const [0.0];

    return List.generate(
      colorCount,
      (index) => segLength * (index / (colorCount - 1)),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

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

    final shader = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(progress.value * 2 * pi),
      colors: _resolvedColors,
      stops: _resolvedStops,
    ).createShader(rect);

    if (glowOpacity > 0 && glowSpread > 0) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.8
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          glowSpread,
        )
        ..blendMode = BlendMode.plus
        ..shader = shader;

      canvas.drawRRect(rrect, glowPaint);
    }

    final mainPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = shader;

    canvas.drawRRect(rrect, mainPaint);
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
        oldDelegate.glowSpread != glowSpread;
  }
}

