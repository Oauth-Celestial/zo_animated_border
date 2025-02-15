import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_dotted_painter.dart';

enum BorderStyleType { gradient, monochrome }

class ZoDottedBorder extends StatefulWidget {
  double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Duration animationDuration;
  final bool animate;
  Color? color;
  Gradient? gradient;
  final BorderStyleType borderStyle;

  Widget child;

  ZoDottedBorder({
    super.key,
    this.borderRadius = 0,
    this.animate = true,
    this.dashLength = 10,
    this.gapLength = 5,
    this.strokeWidth = 3,
    this.color = Colors.blue,
    this.animationDuration = const Duration(seconds: 10),
    this.gradient,
    this.borderStyle = BorderStyleType.monochrome,
    required this.child,
  });

  @override
  State<ZoDottedBorder> createState() => _ZoDottedBorderState();
}

class _ZoDottedBorderState extends State<ZoDottedBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      )..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ZoDottedBorderPainter(
            progress: _controller.value,
            borderRadius: widget.borderRadius,
            dashLength: widget.dashLength,
            gapLength: widget.gapLength,
            strokeWidth: widget.strokeWidth,
            borderStyle: widget.borderStyle,
            color: widget.color ?? Colors.blue,
            gradient: widget.gradient,
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
