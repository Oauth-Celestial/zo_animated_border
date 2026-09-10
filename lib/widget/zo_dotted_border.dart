import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_dotted_painter.dart';

/// The [BorderStyleType] enumeration.
enum BorderStyleType { gradient, monochrome }

/// ![dotted](https://github.com/user-attachments/assets/c1027326-76e4-4f4b-b31d-21303fcb8055)
class ZoDottedBorder extends StatefulWidget {
  /// The border radius of the widget.
  final double borderRadius;
  /// The [dashLength] property.
  final double dashLength;
  /// The length of the gap.
  final double gapLength;
  /// Optional custom stroke width for the border.
  final double strokeWidth;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The [animate] property.
  final bool animate;
  /// The primary color of the border animation.
  final Color color;
  /// The gradient used to color the border.
  final Gradient gradient;
  /// The [borderStyle] property.
  final BorderStyleType borderStyle;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry? padding;

  /// The [animationSpeed] property.
  final double animationSpeed;

  /// The child widget wrapped by the border.
  final Widget child;

  /// The animation curve.
  final Curve animationCurve;

  /// Creates a [ZoDottedBorder] instance.
  const ZoDottedBorder({
    super.key,
    this.borderRadius = 0,
    this.animate = true,
    this.dashLength = 10,
    this.gapLength = 5,
    this.animationSpeed = 0.4,
    this.strokeWidth = 3,
    this.color = Colors.blue,
    this.animationDuration = const Duration(seconds: 10),
    this.gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
    this.borderStyle = BorderStyleType.monochrome,
    this.padding,
    this.animationCurve = Curves.linear,
    required this.child,
  });

  @override
  State<ZoDottedBorder> createState() => _ZoDottedBorderState();
}

class _ZoDottedBorderState extends State<ZoDottedBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ZoDottedBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _curvedAnimation =
          CurvedAnimation(parent: _controller, curve: widget.animationCurve);
    }
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: ZoDottedBorderPainter(
          progress: _curvedAnimation!,
          borderRadius: widget.borderRadius,
          dashLength: widget.dashLength,
          animationSpeed: widget.animationSpeed,
          gapLength: widget.gapLength,
          strokeWidth: widget.strokeWidth,
          borderStyle: widget.borderStyle,
          color: widget.color,
          gradient: widget.gradient,
        ),
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(8.0),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

