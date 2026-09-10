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
    if (size.isEmpty || color.value == null) return;

    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = borderWidth
      ..color = color.value!
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, spreadRadius);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant ZoBreathingBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.spreadRadius != spreadRadius ||
        oldDelegate.borderRadius != borderRadius;
  }
}

