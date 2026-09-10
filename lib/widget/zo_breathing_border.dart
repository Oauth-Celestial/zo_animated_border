import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_breathing_border_painter.dart';

/// ![breathing](https://github.com/user-attachments/assets/2aeb8693-8689-4a17-81b8-16d8aea74dae)
class ZoBreathingBorder extends StatefulWidget {
  /// The thickness of the border.
  final double borderWidth;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// The colors used in the border animation.
  final List<Color> colors;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The child widget wrapped by the border.
  final Widget child;
  /// The animation curve.
  final Curve animationCurve;

  /// Creates a [ZoBreathingBorder] instance.
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

/// A widget that renders [ZoBreathingBorderState].
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
  void didUpdateWidget(covariant ZoBreathingBorder oldWidget) {
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
        painter: ZoBreathingBorderPainter(
          color: _colorAnimation,
          borderWidth: widget.borderWidth,
          borderRadius: widget.borderRadius,
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.borderWidth * 2),
          child: widget.child,
        ),
      ),
    );
  }
}


/// The [ColorTweenSequence] class.
class ColorTweenSequence extends Animatable<Color?> {
  /// The colors used in the border animation.
  final List<Color> colors;

  /// Creates a [ColorTweenSequence] instance.
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
