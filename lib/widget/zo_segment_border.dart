import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_segment_border_painter.dart';

/// A widget that renders [ZoSegmentBorder].
class ZoSegmentBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
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

  /// Creates a [ZoSegmentBorder] instance.
  const ZoSegmentBorder({
    super.key,
    required this.child,
    this.borderRadius = 0,
    this.colors,
    this.stops,
    this.gradient,
    this.segmentLength = 0.15,
    this.glowOpacity = 1.0,
    this.glowRadius = 8.0,
  });

  @override
  State<ZoSegmentBorder> createState() => _ZoSegmentBorderState();
}

class _ZoSegmentBorderState extends State<ZoSegmentBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: ZoSegmentBorderPainter(
            progress: controller,
            borderRadius: widget.borderRadius,
            colors: widget.colors,
            stops: widget.stops,
            gradient: widget.gradient,
            segmentLength: widget.segmentLength,
            glowOpacity: widget.glowOpacity,
            glowRadius: widget.glowRadius,
          ),
          child: widget.child,
        );
      },
    );
  }
}
