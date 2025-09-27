import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_breathing_border_painter.dart';

/// ![breathing](https://github.com/user-attachments/assets/2aeb8693-8689-4a17-81b8-16d8aea74dae)
class ZoBreathingBorder extends StatefulWidget {
  final double borderWidth;
  final BorderRadius borderRadius;
  final List<Color> colors;
  final Duration animationDuration;
  final Widget child;
  final Curve animationCurve;

  const ZoBreathingBorder({
    super.key,
    required this.borderWidth,
    required this.borderRadius,
    required this.colors,
    required this.child,
    this.animationCurve = Curves.linear,
    this.animationDuration = const Duration(seconds: 3),
  });

  @override
  ZoBreathingBorderState createState() => ZoBreathingBorderState();
}

class ZoBreathingBorderState extends State<ZoBreathingBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);

    // Set up the tween for the color animation
    _colorAnimation = ColorTweenSequence(widget.colors).animate(
        CurvedAnimation(parent: _controller, curve: widget.animationCurve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoBreathingBorderPainter(
        color: _colorAnimation,
        borderWidth: widget.borderWidth,
        borderRadius: widget.borderRadius,
      ),
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
