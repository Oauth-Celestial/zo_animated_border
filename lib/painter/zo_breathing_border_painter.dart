import 'package:flutter/material.dart';

class ZoBreathingBorderPainter extends CustomPainter {
  final Animation<Color?> color;
  final double borderWidth;
  final BorderRadius borderRadius;

  ZoBreathingBorderPainter({
    required this.color,
    required this.borderWidth,
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
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = color.value!
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, borderWidth * 2);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
