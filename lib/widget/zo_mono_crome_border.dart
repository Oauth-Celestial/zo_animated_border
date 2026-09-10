import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_track_painter.dart';

/// The [ZoMonoCromeBorderStyle] enumeration.
enum ZoMonoCromeBorderStyle { stroke, repeated, mirror }

/// The [ZoMonoCromeBorderStyle] property.
extension GetBorderStyle on ZoMonoCromeBorderStyle {
  /// The current animation value.
  TileMode get value {
    switch (this) {
      case ZoMonoCromeBorderStyle.stroke:
        return TileMode.clamp;
      case ZoMonoCromeBorderStyle.repeated:
        return TileMode.repeated;
      case ZoMonoCromeBorderStyle.mirror:
        return TileMode.mirror;
    }
  }
}

/// ![mono_chrome (online-video-cutter com)](https://github.com/user-attachments/assets/d798997d-a68c-447e-90e1-5e8fc8dd56bf)
class ZoMonoCromeBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;

  /// The animation controller.
  final ValueChanged<AnimationController>? controller;

  /// The duration of the border animation.
  final Duration animationDuration;

  /// The [cornerRadius] property.
  final double cornerRadius;

  /// The thickness of the border.
  final double borderWidth;

  /// The [trackBorderColor] property.
  final Color trackBorderColor;

  /// Empty space to surround the child.
  final EdgeInsets padding;

  /// The [borderStyle] property.
  final ZoMonoCromeBorderStyle borderStyle;
  /// The animation curve.
  final Curve animationCurve;

  /// Creates a [ZoMonoCromeBorder] instance.
  const ZoMonoCromeBorder(
      {required this.child,
      this.controller,
      this.animationDuration = const Duration(seconds: 4),
      this.cornerRadius = 0.0,
      this.borderWidth = 1,
      this.animationCurve = Curves.linear,
      this.trackBorderColor = Colors.red,
      this.padding = EdgeInsets.zero,
      this.borderStyle = ZoMonoCromeBorderStyle.stroke,
      super.key});

  @override
  ZoMonoCromeBorderState createState() => ZoMonoCromeBorderState();
}

/// A widget that renders [ZoMonoCromeBorderState].
class ZoMonoCromeBorderState extends State<ZoMonoCromeBorder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _curveAnimation;

  @override
  void didUpdateWidget(ZoMonoCromeBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller?.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve && _controller != null) {
      _curveAnimation =
          CurvedAnimation(parent: _controller!, curve: widget.animationCurve);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _curveAnimation =
        CurvedAnimation(parent: _controller!, curve: widget.animationCurve);
    _controller?.repeat();

    if (_controller != null) {
      widget.controller?.call(_controller!);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: ZoTrackPainter(
            animation: _curveAnimation!,
            cornerRadius: widget.cornerRadius,
            trackWidth: widget.borderWidth,
            trackBorderColor: widget.trackBorderColor,
            borderStyle: widget.borderStyle),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

