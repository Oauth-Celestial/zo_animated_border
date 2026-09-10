import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_sequential_glow_border_painter.dart';

/// A widget that renders [ZoSequentialGlowBorder].
class ZoSequentialGlowBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The gradient palettes used for sequential wiping.
  final List<List<Color>> gradientPalettes;
  /// The blur radius of the glow effect.
  final double glowRadius;
  /// The border width.
  final double borderWidth;
  /// The duration of the border animation.
  final Duration duration;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry padding;

  /// Creates a [ZoSequentialGlowBorder] instance.
  const ZoSequentialGlowBorder({
    super.key,
    required this.child,
    this.gradientPalettes = const [
      [Color(0xFF6B2AFF), Color(0xFF00E5FF)], // Purple to Cyan
      [Color(0xFFFF2A85), Color(0xFFFF992A)], // Pink to Orange
      [Color(0xFF00FF87), Color(0xFF60EFFF)], // Green to Blue
    ],
    this.glowRadius = 8.0,
    this.borderWidth = 4.0,
    this.duration = const Duration(seconds: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding = EdgeInsets.zero,
  });

  @override
  State<ZoSequentialGlowBorder> createState() => _ZoSequentialGlowBorderState();
}

class _ZoSequentialGlowBorderState extends State<ZoSequentialGlowBorder>
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
  void didUpdateWidget(covariant ZoSequentialGlowBorder oldWidget) {
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
        painter: ZoSequentialGlowBorderPainter(
          progress: _controller,
          gradientPalettes: widget.gradientPalettes,
          glowRadius: widget.glowRadius,
          borderWidth: widget.borderWidth,
          borderRadius: widget.borderRadius,
        ),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

