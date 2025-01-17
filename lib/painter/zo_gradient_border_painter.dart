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
      this.glowOpacity = 0.8,
      required this.gradientColor});

  List<double> _generateColorStops(List<dynamic> colors) {
    return colors.asMap().entries.map((entry) {
      double percentageStop = entry.key / colors.length;
      return percentageStop;
    }).toList();
  }

  final Paint pulsePaint = Paint()..style = PaintingStyle.stroke;

  SweepGradient get _gradient => SweepGradient(
      colors: gradientColor,
      stops: _generateColorStops(
        gradientColor,
      ),
      transform: GradientRotation(angle));

  @override
  void paint(Canvas canvas, Size size) {
    final Paint glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, glowOpacity * 10);
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
    glowPaint.shader = _gradient.createShader(rect);
    pulsePaint.shader = _gradient.createShader(rect);
    RRect radiiRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 0));
    canvas.drawRRect(radiiRect, glowPaint);

    canvas.drawRRect(radiiRect, borderPaint);
  }

  @override
  bool shouldRepaint(ZoGradientBorderPainter oldDelegate) {
    return true;
  }
}
