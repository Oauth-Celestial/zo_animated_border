import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_segment_border_painter.dart';

class ZoSegmentBorder extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final List<Color>? colors;
  final List<double>? stops;
  final Gradient? gradient;
  final double segmentLength;
  final double glowOpacity;
  final double glowRadius;

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
