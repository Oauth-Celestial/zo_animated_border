import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_scribble_border_painter.dart';

/// A widget that renders [ZoScribbleBorder].
class ZoScribbleBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The border radius of the widget.
  final double borderRadius;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry? padding;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The [borderColor] property.
  final Color borderColor;
  /// The thickness of the border.
  final double borderWidth;
  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;
  /// The spread distance of the glow effect.
  final double glowSpread;

  /// Creates a [ZoScribbleBorder] instance.
  const ZoScribbleBorder(
      {super.key,
      required this.child,
      required this.borderRadius,
      this.padding,
      this.borderColor = Colors.green,
      this.borderWidth = 8,
      this.glowOpacity = 0.6,
      this.glowSpread = 5.0,
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
    if (widget.glowOpacity > 1.0 || widget.glowOpacity < 0.0) {
      throw Exception("Glow opacity should be between 0.0 and 1.0");
    }
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant ZoScribbleBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
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
        painter: ZoScribblePainter(
          color: widget.borderColor,
          borderRadius: widget.borderRadius,
          strokeWidth: widget.borderWidth,
          glowOpacity: widget.glowOpacity,
          glowSpread: widget.glowSpread,
          progress: _controller,
        ),
        child: Container(
          padding: widget.padding, // Space for the border
          child: widget.child,
        ),
      ),
    );
  }
}

