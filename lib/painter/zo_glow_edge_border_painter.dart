import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:zo_animated_border/util/zo_path_helper.dart';

/// A custom painter that renders [ZOGlowingEdgePainter].
class ZOGlowingEdgePainter extends CustomPainter {
  /// The [animation] property.
  final Animation<double> animation;
  /// The thickness of the border.
  final double borderWidth;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [edgeLength] property.
  final double edgeLength;
  /// The colors used in the border animation.
  final List<Color> gradientColors;
  /// The opacity of the outer glow effect.
  final double glowOpacity;
  /// The spread of the glow effect.
  final double glowSpread;

  final List<Color> _fullColors;
  final List<double> _stops;

  /// Creates a [ZOGlowingEdgePainter] instance.
  ZOGlowingEdgePainter({
    required this.animation,
    required this.borderWidth,
    required this.borderRadius,
    required this.edgeLength,
    required this.gradientColors,
    this.glowOpacity = 0.8,
    this.glowSpread = 6.0,
  })  : _fullColors = [
          Colors.transparent,
          ...gradientColors,
          Colors.transparent,
        ],
        _stops = _buildStops(gradientColors.length + 2),
        super(repaint: animation);

  static List<double> _buildStops(int count) {
    if (count <= 1) return const [0.0];
    return List.generate(count, (i) => i / (count - 1));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final path = ZoPathHelper.createRRectPath(
      size,
      BorderRadius.circular(borderRadius),
      inset: borderWidth / 2,
    );
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    for (final metric in metrics) {
      final totalLength = metric.length;
      if (totalLength == 0) continue;

      final actualEdgeLength = math.min(edgeLength, totalLength * 0.8);
      final progress = (animation.value % 1.0) * totalLength;

      final start = progress;
      final end = (progress + actualEdgeLength) % totalLength;

      final snakePath = ZoPathHelper.extractLoopedSubPath(metric, start, end);

      final gradientStart = ZoPathHelper.getTangentPosition(metric, start);
      final gradientEnd = ZoPathHelper.getTangentPosition(metric, end);

      final shader = ui.Gradient.linear(
        gradientStart,
        gradientEnd,
        _fullColors,
        _stops,
      );

      // Glow pass
      if (glowOpacity > 0 && glowSpread > 0) {
        final glowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth
          ..strokeCap = StrokeCap.round
          ..shader = shader
          ..colorFilter = ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, glowOpacity.clamp(0.0, 1.0)),
            BlendMode.modulate,
          )
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, glowSpread);

        canvas.drawPath(snakePath, glowPaint);
      }

      // Foreground sharp stroke
      final paint = Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(snakePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ZOGlowingEdgePainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.edgeLength != edgeLength ||
        oldDelegate.glowOpacity != glowOpacity ||
        oldDelegate.glowSpread != glowSpread ||
        oldDelegate.gradientColors != gradientColors;
  }
}
