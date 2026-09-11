import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_dual_border_painter.dart';
import 'package:zo_animated_border/util/zo_border_radius_resolver.dart';

/// ![dual](https://github.com/user-attachments/assets/5d4123ec-bc72-47cd-825d-7de16f282e7e)
class ZoDualBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The thickness of the border.
  final double borderWidth;
  /// The [firstBorderColor] property.
  final Color firstBorderColor;
  /// The [secondBorderColor] property.
  final Color secondBorderColor;
  /// The [trackBorderColor] property.
  final Color trackBorderColor;
  /// The border radius of the widget. If not specified, automatically detected from [child].
  final BorderRadius? borderRadius;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;
  /// The spread distance of the glow effect.
  final double glowSpread;
  /// Empty space to surround the child.
  final EdgeInsetsGeometry padding;
  /// The animation curve.
  final Curve animationCurve;
  /// Creates a [ZoDualBorder] instance.
  const ZoDualBorder({
    required this.child,
    this.animationDuration = const Duration(seconds: 1),
    this.borderWidth = 3,
    this.glowOpacity = 0.3,
    this.glowSpread = 6.0,
    this.firstBorderColor = Colors.deepOrange,
    this.secondBorderColor = Colors.lightGreen,
    this.trackBorderColor = const Color(0xFFCCCCCC),
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.animationCurve = Curves.linear,
    super.key,
  });

  @override
  ZoDualBorderState createState() => ZoDualBorderState();
}

/// A widget that renders [ZoDualBorderState].
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
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: widget.animationCurve));
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant ZoDualBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = ZoBorderRadiusResolver.resolve(
      widget.child,
      explicit: widget.borderRadius,
    );
    return RepaintBoundary(
      child: CustomPaint(
        painter: ZoDualBorderPainter(
          progress: _animation,
          glowOpacity: widget.glowOpacity,
          glowSpread: widget.glowSpread,
          borderWidth: widget.borderWidth,
          firstBorderColor: widget.firstBorderColor,
          secondBorderColor: widget.secondBorderColor,
          staticBorderColor: widget.trackBorderColor,
          borderRadius: resolvedRadius,
        ),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

