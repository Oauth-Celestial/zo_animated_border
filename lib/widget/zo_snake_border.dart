import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_snake_border_painter.dart';

/// ![snake_border](https://github.com/user-attachments/assets/7e234c6a-dedc-44c7-a03f-0aa052e8a028)
class ZoSnakeBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The thickness of the border.
  final double borderWidth;
  /// The [snakeHeadColor] property.
  final Color snakeHeadColor;
  /// The [snakeTailColor] property.
  final Color snakeTailColor;
  /// The [snakeTrackColor] property.
  final Color snakeTrackColor;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// The animation curve.
  final Curve animationCurve;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;
  /// The spread distance of the glow effect.
  final double glowSpread;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry padding;

  /// Creates a [ZoSnakeBorder] instance.
  const ZoSnakeBorder({
    required this.child,
    this.animationDuration = const Duration(seconds: 10),
    this.borderWidth = 3,
    this.glowOpacity = 0.1,
    this.glowSpread = 6.0,
    this.snakeHeadColor = Colors.deepOrange,
    this.snakeTailColor = Colors.lightGreen,
    this.snakeTrackColor = const Color(0xFFCCCCCC),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding = EdgeInsets.zero,
    this.animationCurve = Curves.linear,
    super.key,
  });

  @override
  ZoSnakeBorderState createState() => ZoSnakeBorderState();
}

/// A widget that renders [ZoSnakeBorderState].
class ZoSnakeBorderState extends State<ZoSnakeBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.glowOpacity > 1.0 || widget.glowOpacity < 0.0) {
      throw Exception("Glow opacity should be between 0.0 and 1.0");
    }
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: widget.animationCurve));
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant ZoSnakeBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve));
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
        painter: ZoSnakeBorderPainter(
          progress: _animation,
          glowOpacity: widget.glowOpacity,
          glowSpread: widget.glowSpread,
          borderWidth: widget.borderWidth,
          colorFrom: widget.snakeHeadColor,
          colorTo: widget.snakeTailColor,
          staticBorderColor: widget.snakeTrackColor,
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

