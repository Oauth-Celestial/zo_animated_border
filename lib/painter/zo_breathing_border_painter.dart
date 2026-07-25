import 'package:flutter/material.dart';

/// A custom painter that renders [ZoBreathingBorderPainter].
class ZoBreathingBorderPainter extends CustomPainter {
  /// The primary color of the border animation.
  final Animation<Color?> color;
  /// The thickness of the border.
  final double borderWidth;
  /// The [spreadRadius] property.
  final double spreadRadius;
  /// The border radius of the widget.
  final BorderRadius borderRadius;

  /// Creates a [ZoBreathingBorderPainter] instance.
  ZoBreathingBorderPainter({
    required this.color,
    required this.borderWidth,
    this.spreadRadius = 10,
    required this.borderRadius,
  }) : super(repaint: color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );
    final rrect = borderRadius.toRRect(rect);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = borderWidth
      ..color = color.value!
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, spreadRadius);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
