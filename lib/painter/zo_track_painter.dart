import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:zo_animated_border/widget/zo_mono_crome_border.dart';

/// A custom painter that renders [ZoTrackPainter].
class ZoTrackPainter extends CustomPainter {
  /// Animation of the AnimationController
  final Animation animation;

  /// Corner radius of the border
  final double cornerRadius;

  /// Width of the border
  final double trackWidth;

  /// Color of the border
  final Color trackBorderColor;

  /// The [borderStyle] property.
  final ZoMonoCromeBorderStyle borderStyle;

  /// Creates a [ZoTrackPainter] instance.
  ZoTrackPainter(
      {required this.animation,
      required this.cornerRadius,
      required this.trackWidth,
      required this.trackBorderColor,
      this.borderStyle = ZoMonoCromeBorderStyle.stroke})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    /// Painting the border
    final rect = Offset.zero & size;
    final paint = Paint()..color = Colors.transparent;
    final progress = animation.value;

    if (progress > 0.0) {
      paint.color = trackBorderColor;
      paint.shader = SweepGradient(
        tileMode: borderStyle.value,
        colors: [
          trackBorderColor.withAlpha(0),
          trackBorderColor,
          trackBorderColor.withAlpha(0)
        ],
        stops: const [
          0.0,
          1.0,
          1.0,
        ],
        startAngle: math.pi / 8,
        endAngle: math.pi / 2,
        transform: GradientRotation(
          (math.pi * 2 * progress),
        ),
      ).createShader(rect);
    }

    var rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(cornerRadius),
    );

    final path = Path()..addRRect(rRect);

    canvas.drawRRect(
      rRect,
      paint
        ..strokeWidth = trackWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ZoTrackPainter oldDelegate) => true;
}
