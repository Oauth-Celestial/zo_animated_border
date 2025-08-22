import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_glow_edge_border_painter.dart';

/// ![glowEdge](https://github.com/user-attachments/assets/11950588-e76c-48ca-bbd7-5ca5ec988380)
class ZoGlowingEdgeBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final double edgeLength;
  final Duration animationDuration;
  final List<Color> gradientColors;

  const ZoGlowingEdgeBorder({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderWidth = 4.0,
    this.animationDuration = const Duration(seconds: 3),
    this.borderRadius = 5.0,
    this.edgeLength = 120.0,
  });

  @override
  State<ZoGlowingEdgeBorder> createState() => _ZoGlowingEdgeBorderState();
}

class _ZoGlowingEdgeBorderState extends State<ZoGlowingEdgeBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZOGlowingEdgePainter(
        animation: _controller,
        borderWidth: widget.borderWidth,
        borderRadius: widget.borderRadius,
        edgeLength: widget.edgeLength,
        gradientColors: widget.gradientColors,
      ),
      child: widget.child,
    );
  }
}
