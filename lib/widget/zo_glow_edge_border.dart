import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_glow_edge_border_painter.dart';
import 'package:zo_animated_border/util/zo_border_radius_resolver.dart';

/// ![glowEdge](https://github.com/user-attachments/assets/11950588-e76c-48ca-bbd7-5ca5ec988380)
class ZoGlowingEdgeBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The thickness of the border.
  final double borderWidth;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [edgeLength] property.
  final double edgeLength;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The colors used in the border animation.
  final List<Color> gradientColors;
  /// The animation curve.
  final Curve animationCurve;
  /// How much the border should glow (0.0 to 1.0).
  final double glowOpacity;
  /// The spread distance of the glow effect.
  final double glowSpread;

  /// Creates a [ZoGlowingEdgeBorder] instance.
  const ZoGlowingEdgeBorder({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderWidth = 4.0,
    this.animationDuration = const Duration(seconds: 3),
    this.borderRadius = 5.0,
    this.edgeLength = 120.0,
    this.glowOpacity = 0.8,
    this.glowSpread = 6.0,
    this.animationCurve = Curves.linear,
  });

  @override
  State<ZoGlowingEdgeBorder> createState() => _ZoGlowingEdgeBorderState();
}

class _ZoGlowingEdgeBorderState extends State<ZoGlowingEdgeBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
    _curveAnimation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
  }

  @override
  void didUpdateWidget(covariant ZoGlowingEdgeBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _curveAnimation =
          CurvedAnimation(parent: _controller, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = widget.borderRadius == 5.0
        ? (ZoBorderRadiusResolver.autoDetect(widget.child)?.topLeft.x ?? widget.borderRadius)
        : widget.borderRadius;

    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: ZOGlowingEdgePainter(
          animation: _curveAnimation,
          borderWidth: widget.borderWidth,
          borderRadius: resolvedRadius,
          edgeLength: widget.edgeLength,
          glowOpacity: widget.glowOpacity,
          glowSpread: widget.glowSpread,
          gradientColors: widget.gradientColors,
        ),
        child: widget.child,
      ),
    );
  }
}
