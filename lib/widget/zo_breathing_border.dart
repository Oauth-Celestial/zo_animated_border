import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_breathing_border_painter.dart';

class ZoBreathingBorder extends StatefulWidget {
  final double borderWidth;
  final BorderRadius borderRadius;
  final List<Color> colors;
  final Duration duration;
  final Widget child;

  const ZoBreathingBorder({
    Key? key,
    required this.borderWidth,
    required this.borderRadius,
    required this.colors,
    required this.child,
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _ZoBreathingBorderState createState() => _ZoBreathingBorderState();
}

class _ZoBreathingBorderState extends State<ZoBreathingBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    // Set up the tween for the color animation
    _colorAnimation = ColorTweenSequence(widget.colors).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: ZoBreathingBorderPainter(
            color: _colorAnimation.value ?? widget.colors.first,
            borderWidth: widget.borderWidth,
            borderRadius: widget.borderRadius,
          ),
          child: child,
        );
      },
      child: Padding(
        padding: EdgeInsets.all(widget.borderWidth * 2),
        child: widget.child,
      ),
    );
  }
}

class ColorTweenSequence extends Animatable<Color?> {
  final List<Color> colors;

  ColorTweenSequence(this.colors);

  @override
  Color? transform(double t) {
    final length = colors.length;
    final interval = 1.0 / (length - 1);
    final currentIndex = (t / interval).floor().clamp(0, length - 2);
    final startColor = colors[currentIndex];
    final endColor = colors[currentIndex + 1];
    final progress = (t % interval) / interval;

    return Color.lerp(startColor, endColor, progress);
  }
}
