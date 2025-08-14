import 'package:flutter/material.dart';

class ZoSignalPainter extends CustomPainter {
  final Animation<double> progress;
  final List<Color> ringColors;
  final double borderRadius;
  final double maxRadius;

  ZoSignalPainter(
      {required this.progress,
      required this.ringColors,
      required this.maxRadius,
      this.borderRadius = 0})
      : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < ringColors.length; i++) {
      double rippleProgress = (progress.value + (i / ringColors.length)) % 1.0;
      double radius = rippleProgress * maxRadius;

      final paint = Paint()
        ..color = ringColors[i].withValues(alpha: 1.0 - rippleProgress)
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
        oldDelegate.ringColors != ringColors;
  }
}
