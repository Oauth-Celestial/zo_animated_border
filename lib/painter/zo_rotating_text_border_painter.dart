import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class ZoPathTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final double padding;
  final AnimationController progress;

  ZoPathTextPainter({
    required this.text,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Define the Path (RRect based on child size + padding)
    final Rect rect = Offset(-padding, -padding) &
        Size(size.width + padding * 2, size.height + padding * 2);
    final RRect rrect = borderRadius.toRRect(rect);
    final Path path = Path()..addRRect(rrect);

    final PathMetric metric = path.computeMetrics().first;
    final double pathLength = metric.length;

    // 2. Measure individual characters
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    List<double> charWidths = [];
    double totalTextWidth = 0;

    for (int i = 0; i < text.length; i++) {
      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();
      // Add extra space between characters for readability
      double widthWithSpacing =
          textPainter.width + (textStyle.letterSpacing ?? 0);
      charWidths.add(widthWithSpacing);
      totalTextWidth += widthWithSpacing;
    }

    // 3. Spacing logic
    double gapBetweenRepeats = 40.0;
    int repeats = (pathLength / (totalTextWidth + gapBetweenRepeats)).floor();
    repeats = math.max(1, repeats);
    double segmentLength = pathLength / repeats;

    for (int r = 0; r < repeats; r++) {
      double currentDist = (progress.value * pathLength) + (r * segmentLength);

      for (int i = 0; i < text.length; i++) {
        double actualDist = currentDist % pathLength;
        Tangent? tangent = metric.getTangentForOffset(actualDist);

        if (tangent != null) {
          textPainter.text = TextSpan(text: text[i], style: textStyle);
          textPainter.layout();

          canvas.save();

          canvas.translate(tangent.position.dx, tangent.position.dy);

          canvas.rotate(-tangent.angle);

          canvas.translate(0, -textPainter.height / 2);
          textPainter.paint(canvas, Offset(-textPainter.width / 2, 0));
          canvas.restore();
        }
        currentDist += charWidths[i];
      }
    }
  }

  @override
  bool shouldRepaint(ZoPathTextPainter oldDelegate) => true;
}
