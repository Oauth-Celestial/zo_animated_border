import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_scribble_border_painter.dart';

class ZoScribbleBorder extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Duration animationDuration;
  final Color borderColor;
  final double borderWidth;
  final double glowOpacity;

  const ZoScribbleBorder(
      {super.key,
      required this.child,
      required this.borderRadius,
      this.padding,
      this.borderColor = Colors.green,
      this.borderWidth = 8,
      this.glowOpacity = 8,
      this.animationDuration = const Duration(seconds: 4)});

  @override
  State<ZoScribbleBorder> createState() => _ZoScribbleBorderState();
}

class _ZoScribbleBorderState extends State<ZoScribbleBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);
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
          painter: ZoScribblePainter(
              color: widget.borderColor,
              borderRadius: widget.borderRadius,
              strokeWidth: widget.borderWidth,
              blur: widget.glowOpacity,
              progress: _controller),
          child: Container(
            padding: widget.padding, // Space for the border
            child: widget.child,
          ),
        );
      },
    );
  }
}
