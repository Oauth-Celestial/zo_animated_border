import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_snake_border_painter.dart';

class ZoSnakeBorder extends StatefulWidget {
  final Widget child;
  final double duration;
  final double borderWidth;
  final Color snakeHeadColor;
  final Color snakeTailColor;
  final Color snakeTrackColor;
  final BorderRadius borderRadius;
  double glowOpacity;
  final EdgeInsetsGeometry padding;

  ZoSnakeBorder({
    required this.child,
    this.duration = 15,
    this.borderWidth = 3,
    this.glowOpacity = 8,
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: ZoSnakeBorderPainter(
            progress: _animation.value,
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
      },
    );
  }
}
