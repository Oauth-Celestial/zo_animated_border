import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_hand_drawn_border_painter.dart';

class ZoHandDrawnBorder extends StatefulWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final Duration animationDuration;
  final Color borderColor;
  final double borderWidth;
  final double glowOpacity;

  const ZoHandDrawnBorder(
      {super.key,
      required this.child,
      required this.radius,
      this.padding,
      this.borderColor = Colors.green,
      this.borderWidth = 8,
      this.glowOpacity = 8,
      this.animationDuration = const Duration(seconds: 4)});

  @override
  State<ZoHandDrawnBorder> createState() => _ZoHandDrawnBorderState();
}

class _ZoHandDrawnBorderState extends State<ZoHandDrawnBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true); // Subtle continuous movement
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ZoHandDrawnPainter(
              color: widget.borderColor,
              strokeWidth: widget.borderWidth,
              blur: widget.glowOpacity,
              progress: _controller.value),
          child: Container(
            padding: widget.padding, // Space for the border
            child: widget.child,
          ),
        );
      },
    );
  }
}
