import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:zo_animated_border/painter/zo_track_painter.dart';

enum ZoMonoCromeBorderStyle { stroke, repeated, mirror }

extension GetBorderStyle on ZoMonoCromeBorderStyle {
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
  final Widget child;

  final ValueChanged<AnimationController>? controller;

  final Duration duration;

  final double cornerRadius;

  final double borderWidth;

  final Color trackBorderColor;

  final EdgeInsets padding;

  final ZoMonoCromeBorderStyle borderStyle;

  const ZoMonoCromeBorder(
      {required this.child,
      this.controller,
      this.duration = const Duration(seconds: 4),
      this.cornerRadius = 0.0,
      this.borderWidth = 1,
      this.trackBorderColor = Colors.red,
      this.padding = EdgeInsets.zero,
      this.borderStyle = ZoMonoCromeBorderStyle.stroke,
      super.key});

  @override
  ZoMonoCromeBorderState createState() => ZoMonoCromeBorderState();
}

class ZoMonoCromeBorderState extends State<ZoMonoCromeBorder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void didUpdateWidget(ZoMonoCromeBorder oldWidget) {
    if (oldWidget != oldWidget) {
      _controller?.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.reverse) {}
      });

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
    return CustomPaint(
      painter: ZoTrackPainter(
          animation: _controller!,
          cornerRadius: widget.cornerRadius,
          trackWidth: widget.borderWidth,
          trackBorderColor: widget.trackBorderColor,
          borderStyle: widget.borderStyle),
      child: Padding(
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }

  int getRandomNumber() {
    var random = math.Random();
    return (random.nextInt(20) + 6);
  }
}
