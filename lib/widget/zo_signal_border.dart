import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_signal_painter.dart';

/// A widget that renders [ZoSignalBorder].
class ZoSignalBorder extends StatefulWidget {
  /// The [ringColors] property.
  final List<Color> ringColors;
  /// The child widget wrapped by the border.
  final Widget child;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [minRadius] property.
  final double? minRadius;
  /// The [maxRadius] property.
  final double maxRadius;
  /// The animation curve.
  final Curve animationCurve;

  /// Creates a [ZoSignalBorder] instance.
  const ZoSignalBorder(
      {super.key,
      required this.ringColors,
      required this.child,
      this.minRadius,
      this.maxRadius = 180,
      this.animationCurve = Curves.linear,
      this.animationDuration = const Duration(seconds: 3),
      this.borderRadius = 0});

  @override
  State<ZoSignalBorder> createState() => _ZoSignalBorderState();
}

class _ZoSignalBorderState extends State<ZoSignalBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final effectiveMinRadius =
          widget.minRadius ?? (constraints.biggest.shortestSide / 2);
      return CustomPaint(
          painter: ZoSignalPainter(
            minRadius: effectiveMinRadius,
            maxRadius: widget.maxRadius,
            borderRadius: widget.borderRadius,
            progress: _curvedAnimation,
            ringColors: widget.ringColors,
          ),
          child: widget.child);
    });
  }
}
