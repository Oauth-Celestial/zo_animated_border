import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_snake_border_painter.dart';

/// ![snake_border](https://github.com/user-attachments/assets/7e234c6a-dedc-44c7-a03f-0aa052e8a028)
class ZoSnakeBorder extends StatefulWidget {
  final Widget child;
  final double duration;
  final double borderWidth;
  final Color snakeHeadColor;
  final Color snakeTailColor;
  final Color snakeTrackColor;
  final BorderRadius borderRadius;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;
  final EdgeInsetsGeometry padding;

  const ZoSnakeBorder({
    required this.child,
    this.duration = 15,
    this.borderWidth = 3,
    this.glowOpacity = 0.1,
    this.snakeHeadColor = Colors.deepOrange,
    this.snakeTailColor = Colors.lightGreen,
    this.snakeTrackColor = const Color(0xFFCCCCCC),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding = EdgeInsets.zero,
    super.key,
  });

  @override
  ZoSnakeBorderState createState() => ZoSnakeBorderState();
}

class ZoSnakeBorderState extends State<ZoSnakeBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.glowOpacity >= 1.0 || widget.glowOpacity < 0.0) {
      throw Exception("Glow opacity should be between 0.0 and 1.0");
    }
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration.toInt()),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoSnakeBorderPainter(
        progress: _animation,
        glowOpacity: widget.glowOpacity,
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
    );
  }
}
