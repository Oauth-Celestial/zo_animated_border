import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_rotating_text_border_painter.dart';

class ZoCircularTextBorder extends StatefulWidget {
  final String text;
  final double radius;
  final TextStyle textStyle;
  final Duration rotationDuration;
  final Widget child;
  final bool animate;

  const ZoCircularTextBorder(
      {super.key,
      required this.text,
      required this.radius,
      required this.textStyle,
      this.animate = true,
      this.rotationDuration = const Duration(seconds: 12),
      required this.child});

  @override
  State<ZoCircularTextBorder> createState() => _ZoCircularTextBorderState();
}

class _ZoCircularTextBorderState extends State<ZoCircularTextBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    );

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoRotatingTextBorderPainter(
        text: widget.text,
        radius: widget.radius,
        textStyle: widget.textStyle,
        progress: _controller,
      ),
      child: widget.child,
    );
  }
}
