import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_dotted_painter.dart';

enum BorderStyleType { gradient, monochrome }

/// ![dotted](https://github.com/user-attachments/assets/c1027326-76e4-4f4b-b31d-21303fcb8055)
class ZoDottedBorder extends StatefulWidget {
  final double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Duration animationDuration;
  final bool animate;
  final Color color;
  final Gradient gradient;
  final BorderStyleType borderStyle;
  final EdgeInsetsGeometry? padding;

  final double animationSpeed;

  final Widget child;

  const ZoDottedBorder({
    super.key,
    this.borderRadius = 0,
    this.animate = true,
    this.dashLength = 10,
    this.gapLength = 5,
    this.animationSpeed = 0.4,
    this.strokeWidth = 3,
    this.color = Colors.blue,
    this.animationDuration = const Duration(seconds: 10),
    this.gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
    this.borderStyle = BorderStyleType.monochrome,
    this.padding,
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
    return CustomPaint(
      painter: ZoDottedBorderPainter(
        progress: _controller,
        borderRadius: widget.borderRadius,
        dashLength: widget.dashLength,
        animationSpeed: widget.animationSpeed,
        gapLength: widget.gapLength,
        strokeWidth: widget.strokeWidth,
        borderStyle: widget.borderStyle,
        color: widget.color,
        gradient: widget.gradient,
      ),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(8.0),
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
