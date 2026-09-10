import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_psycho_border_painter.dart';

/// A widget that renders [ZoPsychoBorder].
class ZoPsychoBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget? child;
  /// The number of concentric rings.
  final int ringCount;
  /// The colors used in the border animation.
  final List<Color> colors;
  /// The maximum spread distance between rings.
  final double maxSpread;
  /// The duration of the border animation.
  final Duration duration;
  /// The border radius of the widget.
  final BorderRadius borderRadius;

  /// Creates a [ZoPsychoBorder] instance.
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
    return RepaintBoundary(
      child: CustomPaint(
        painter: ZoPsychoBorderPainter(
          progress: _controller,
          ringCount: widget.ringCount,
          colors: widget.colors,
          maxSpread: widget.maxSpread,
          borderRadius: widget.borderRadius,
        ),
        child: widget.child,
      ),
    );
  }
}

