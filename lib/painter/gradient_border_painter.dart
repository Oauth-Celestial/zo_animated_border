import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  double angle;
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..color = Colors.black;
  BorderPainter({
    required this.angle,
  });

  List<Color> colors = [Colors.yellowAccent, Colors.greenAccent, Colors.blue];
  List<double> _generateColorStops(List<dynamic> colors) {
    return colors.asMap().entries.map((entry) {
      double percentageStop = entry.key / colors.length;
      return percentageStop;
    }).toList();
  }

  final Paint glowPaint = Paint()
    ..style = PaintingStyle.fill
    ..maskFilter = MaskFilter.blur(BlurStyle.outer, 8);

  final Paint pulsePaint = Paint()..style = PaintingStyle.stroke;

  SweepGradient get _gradient => SweepGradient(
      colors: colors,
      stops: _generateColorStops(
        colors,
      ),
      transform: GradientRotation(angle));

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    _paint.shader = _gradient.createShader(rect);
    glowPaint.shader = _gradient.createShader(rect);
    pulsePaint.shader = _gradient.createShader(rect);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(10)), glowPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(10)), _paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) {
    return true;
  }
}
