import 'package:flutter/material.dart';

class ZoGradientBorderPainter extends CustomPainter {
  double angle;
  double? borderRadius;
  double borderThickness;
  List<Color> gradientColor;
  double glowOpacity;
  ZoGradientBorderPainter(
      {required this.angle,
      this.borderRadius,
      this.borderThickness = 5,
      this.glowOpacity = 0.3,
      required this.gradientColor});

  List<double> _generateColorStops(List<dynamic> colors) {
    return colors.asMap().entries.map((entry) {
      double percentageStop = entry.key / colors.length;
      return percentageStop;
    }).toList();
  }

  final Paint pulsePaint = Paint()..style = PaintingStyle.stroke;

  LinearGradient get _gradient => LinearGradient(
      colors: gradientColor,
      stops: _generateColorStops(
        gradientColor,
      ),
      transform: GradientRotation(angle));

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    borderPaint.shader = _gradient.createShader(rect);

    RRect radiiRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 0));

    for (int i = 1; i <= glowOpacity * 10; i++) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, (10 * i).toDouble())
        ..strokeWidth = borderThickness;

      glowPaint.shader = _gradient.createShader(rect);

      canvas.drawRRect(radiiRect, glowPaint);
    }
    canvas.drawRRect(radiiRect, borderPaint);
  }

  @override
  bool shouldRepaint(ZoGradientBorderPainter oldDelegate) {
    return true;
  }
}
