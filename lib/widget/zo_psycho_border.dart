import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_psycho_border_painter.dart';

class ZoPsychoBorder extends StatefulWidget {
  final Widget? child;
  final int ringCount;
  final List<Color> colors;
  final double maxSpread;
  final Duration duration;
  final BorderRadius borderRadius;

  const ZoPsychoBorder({
    super.key,
    this.child,
    this.ringCount = 3,
    this.maxSpread = 8.0,
    this.colors = const [
      Color(0xFFFF2A85),
      Color(0xFFFF992A),
      Color(0xFF00E5FF),
    ],
    this.duration = const Duration(seconds: 3),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  State<ZoPsychoBorder> createState() => _ZoPsychoBorderState();
}

class _ZoPsychoBorderState extends State<ZoPsychoBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant ZoPsychoBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ZoPsychoBorderPainter(
            progress: _controller.value,
            ringCount: widget.ringCount,
            colors: widget.colors,
            maxSpread: widget.maxSpread,
            borderRadius: widget.borderRadius,
          ),
          child: widget.child,
        );
      },
    );
  }
}
