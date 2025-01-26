import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_dual_border_painter.dart';

class ZoDualBorder extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double borderWidth;
  final Color firstBorderColor;
  final Color secondBorderColor;
  final Color trackBorderColor;
  final BorderRadius borderRadius;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;
  final EdgeInsetsGeometry padding;

  const ZoDualBorder({
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.borderWidth = 3,
    this.glowOpacity = 0.3,
    this.firstBorderColor = Colors.deepOrange,
    this.secondBorderColor = Colors.lightGreen,
    this.trackBorderColor = const Color(0xFFCCCCCC),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding = EdgeInsets.zero,
    super.key,
  });

  @override
  ZoDualBorderState createState() => ZoDualBorderState();
}

class ZoDualBorderState extends State<ZoDualBorder>
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
      duration: widget.duration,
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
          painter: ZoDualBorderPainter(
            progress: _animation.value,
            glowOpacity: widget.glowOpacity,
            borderWidth: widget.borderWidth,
            firstBorderColor: widget.firstBorderColor,
            secondBorderColor: widget.secondBorderColor,
            staticBorderColor: widget.trackBorderColor,
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
