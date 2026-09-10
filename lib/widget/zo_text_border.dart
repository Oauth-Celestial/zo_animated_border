import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_rotating_text_border_painter.dart';

/// A widget that renders [ZoTextBorder].
class ZoTextBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The text string displayed along the border.
  final String text;
  /// The text style for the border text.
  final TextStyle textStyle;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// Empty space to surround the child.
  final double padding;
  /// The duration of the border animation.
  final Duration duration;

  /// Creates a [ZoTextBorder] instance.
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
  void didUpdateWidget(covariant ZoTextBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
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
      child: Stack(
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
      ),
    );
  }
}

