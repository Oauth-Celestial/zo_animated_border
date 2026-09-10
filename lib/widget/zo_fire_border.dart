import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_fire_border_painter.dart';

/// A widget that renders [ZoFireBorder].
class ZoFireBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The duration of the border animation.
  final Duration duration;
  /// The thickness of the border.
  final double borderWidth;
  /// The relative length of the snake border segment.
  final double snakeLength; // New parameter: 0.0 to 1.0
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// The gradient used to color the border.
  final Gradient gradient;
  /// The colors of trailing particles.
  final List<Color>? particleColors;

  /// Creates a [ZoFireBorder] instance.
  const ZoFireBorder({
    super.key,
    required this.child,
    required this.duration,
    required this.borderWidth,
    this.snakeLength = 0.1, // Default to 10%
    required this.borderRadius,
    required this.gradient,
    this.particleColors,
  });

  @override
  State<ZoFireBorder> createState() => _ZoFireBorderState();
}

class _ZoFireBorderState extends State<ZoFireBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final List<Particle> particles = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant ZoFireBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: ZoFireBorderPainter(
          progress: controller,
          borderWidth: widget.borderWidth,
          snakeLength: widget.snakeLength,
          gradient: widget.gradient,
          borderRadius: widget.borderRadius,
          particles: particles,
          particleColors: widget.particleColors,
          random: random,
        ),
        child: widget.child,
      ),
    );
  }
}

