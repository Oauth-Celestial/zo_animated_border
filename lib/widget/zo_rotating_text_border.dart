import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_rotating_text_border_painter.dart';

class ZoRotatingTextBorder extends StatefulWidget {
  final String text;
  final double radius;
  final TextStyle textStyle;
  final Duration rotationDuration;

  const ZoRotatingTextBorder({
    super.key,
    required this.text,
    required this.radius,
    required this.textStyle,
    required this.rotationDuration,
  });

  @override
  State<ZoRotatingTextBorder> createState() => _ZoRotatingTextBorderState();
}

class _ZoRotatingTextBorderState extends State<ZoRotatingTextBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(widget.radius * 2),
      painter: ZoRotatingTextBorderPainter(
        text: widget.text,
        radius: widget.radius,
        textStyle: widget.textStyle,
        progress: _controller,
      ),
    );
  }
}
