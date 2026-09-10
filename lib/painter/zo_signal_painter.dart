import 'package:flutter/material.dart';

/// A custom painter that renders [ZoSignalPainter].
class ZoSignalPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The [ringColors] property.
  final List<Color> ringColors;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [minRadius] property.
  final double? minRadius;
  /// The spacing between two consecutive borders.
  final double spaceBetween;

  /// Creates a [ZoSignalPainter] instance.
  ZoSignalPainter(
      {required this.progress,
      required this.ringColors,
      this.minRadius,
      this.spaceBetween = 20,
      this.borderRadius = 0})
      : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || ringColors.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final effectiveMinRadius = minRadius ?? (size.shortestSide / 2);
    final double totalSpread = ringColors.length * spaceBetween;

    for (int i = 0; i < ringColors.length; i++) {
      double rippleProgress = (progress.value + (i / ringColors.length)) % 1.0;
      double radius = effectiveMinRadius + totalSpread * rippleProgress;

      final paint = Paint()
        ..color = ringColors[i].withValues(alpha: (1.0 - rippleProgress).clamp(0.0, 1.0))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      if (borderRadius == 0) {
        canvas.drawCircle(center, radius, paint);
      } else {
        final rect = Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 2,
        );
        final rrect =
            RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
        canvas.drawRRect(rrect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ZoSignalPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringColors != ringColors ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.minRadius != minRadius ||
        oldDelegate.spaceBetween != spaceBetween;
  }
}

