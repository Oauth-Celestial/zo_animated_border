import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_multi_color_border.dart';

/// ![multicolor](https://github.com/user-attachments/assets/cb66375f-f9a9-48cc-93fe-45d56854bbd6)
class ZoMultiColorBorder extends StatefulWidget {
  /// The border radius of the widget.
  final double borderRadius;

  /// The length of the gap.
  final double gapLength;
  /// Optional custom stroke width for the border.
  final double strokeWidth;
  /// The child widget wrapped by the border.
  final Widget child;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry? padding;

  /// The duration of the border animation.
  final Duration animationDuration;

  /// The colors used in the border animation.
  final List<Color> colors;
  /// The [animate] property.
  final bool animate;
  /// The animation curve.
  final Curve animationCurve;
  /// Creates a [ZoMultiColorBorder] instance.
  const ZoMultiColorBorder(
      {super.key,
      required this.child,
      this.borderRadius = 0,
      this.gapLength = 0,
      this.animationDuration = const Duration(seconds: 2),
      this.strokeWidth = 3,
      this.animate = true,
      this.padding,
      this.animationCurve = Curves.linear,
      this.colors = const [Colors.blue, Colors.black]});

  @override
  State<ZoMultiColorBorder> createState() => _ZoMultiColorBorderState();
}

class _ZoMultiColorBorderState extends State<ZoMultiColorBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _curveAnimation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ZoMultiColorBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _curveAnimation =
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(8.0),
        child: CustomPaint(
            painter: ZoMultiColorBorderPainter(
                progress: _curveAnimation,
                colors: widget.colors,
                borderRadius: widget.borderRadius,
                borderWidth: widget.strokeWidth,
                gapLength: widget.gapLength),
            child: widget.child),
      ),
    );
  }
}

