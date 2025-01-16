import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/snake_border_painter.dart';

class ZoSnakeBorder extends StatefulWidget {
  final Widget child;
  final double duration;
  final double borderWidth;
  final Color snakeHeadColor;
  final Color snakeTailColor;
  final Color staticBorderColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  const ZoSnakeBorder({
    required this.child,
    this.duration = 15,
    this.borderWidth = 1.5,
    this.snakeHeadColor = const Color(0xFFFFAA40),
    this.snakeTailColor = const Color(0xFF9C40FF),
    this.staticBorderColor = const Color(0xFFCCCCCC),
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
          painter: SnakeBorderPainter(
            progress: _animation.value,
            borderWidth: widget.borderWidth,
            colorFrom: widget.snakeHeadColor,
            colorTo: widget.snakeTailColor,
            staticBorderColor: widget.staticBorderColor,
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
