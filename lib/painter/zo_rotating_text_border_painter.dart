import 'dart:math' as math;

import 'package:flutter/material.dart';

class ZoRotatingTextBorderPainter extends CustomPainter {
  final String text;
  final double radius;
  final TextStyle textStyle;
  final Animation<double> progress;

  late List<TextPainter> _charPainters;
  late List<double> _charWidths;
  late double _totalTextWidth;

  ZoRotatingTextBorderPainter({
    required this.text,
    required this.radius,
    required this.textStyle,
    required this.progress,
  }) : super(repaint: progress) {
    _initTextMetrics();
  }

  void _initTextMetrics() {
    _charPainters = [];
    _charWidths = [];
    _totalTextWidth = 0;

    for (final char in text.characters) {
      final painter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      _charPainters.add(painter);
      _charWidths.add(painter.width);
      _totalTextWidth += painter.width;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const totalAngle = 2 * math.pi;

    double startAngle = -math.pi / 2 + (progress.value * totalAngle);

    final dotSize = textStyle.fontSize!;
    final circumference = totalAngle * radius;
    final segmentWidth = _totalTextWidth + dotSize;

    final repetitions = math.max(1, (circumference / segmentWidth).floor());

    final segmentAngle = totalAngle / repetitions;
    final textAngle = (_totalTextWidth / segmentWidth) * segmentAngle;
    final dotAngle = segmentAngle - textAngle;

    for (int i = 0; i < repetitions; i++) {
      _drawDot(canvas, center, startAngle);

      double currentAngle = startAngle + dotAngle / 2;

      for (int c = 0; c < _charPainters.length; c++) {
        final proportion = _charWidths[c] / _totalTextWidth;
        final charAngle = textAngle * proportion;
        final angle = currentAngle + charAngle / 2;

        final offset = Offset(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        );

        canvas.save();
        canvas.translate(offset.dx, offset.dy);
        canvas.rotate(angle + math.pi / 2);

        _charPainters[c].paint(
          canvas,
          Offset(
            -_charWidths[c] / 2,
            -_charPainters[c].height / 2,
          ),
        );

        canvas.restore();
        currentAngle += charAngle;
      }

      startAngle += segmentAngle;
    }
  }

  void _drawDot(Canvas canvas, Offset center, double angle) {
    final paint = Paint()
      ..color = textStyle.color!
      ..style = PaintingStyle.fill;

    final offset = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    canvas.drawCircle(offset, textStyle.fontSize! / 4, paint);
  }

  @override
  bool shouldRepaint(covariant ZoRotatingTextBorderPainter old) {
    return old.progress != progress ||
        old.text != text ||
        old.radius != radius ||
        old.textStyle != textStyle;
  }
}
