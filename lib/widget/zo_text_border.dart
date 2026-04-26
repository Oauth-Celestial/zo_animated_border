import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_rotating_text_border_painter.dart';

class ZoTextBorder extends StatefulWidget {
  final Widget child;
  final String text;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final double padding;
  final Duration duration;

  const ZoTextBorder({
    super.key,
    required this.child,
    required this.text,
    this.borderRadius = BorderRadius.zero,
    this.padding = 10.0,
    this.duration = const Duration(seconds: 10),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 12),
  });

  @override
  State<ZoTextBorder> createState() => _ZoTextBorderState();
}

class _ZoTextBorderState extends State<ZoTextBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: ZoPathTextPainter(
              text: widget.text,
              textStyle: widget.textStyle,
              borderRadius: widget.borderRadius,
              padding: widget.padding,
              progress: _controller,
            ),
          ),
        ),
      ],
    );
  }
}
