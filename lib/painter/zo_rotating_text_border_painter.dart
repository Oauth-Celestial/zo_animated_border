import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom painter that renders [ZoPathTextPainter].
class ZoPathTextPainter extends CustomPainter {
  /// The text string displayed along the border.
  final String text;
  /// The text style for the border text.
  final TextStyle textStyle;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// Empty space to surround the child.
  final double padding;
  /// The current progress of the animation from 0.0 to 1.0.
  final AnimationController progress;

  final List<TextPainter> _charPainters;
  final List<double> _charWidths;
  final double _totalTextWidth;

  /// Creates a [ZoPathTextPainter] instance.
  ZoPathTextPainter({
    required this.text,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.progress,
  })  : _charPainters = _buildCharPainters(text, textStyle),
        _charWidths = _measureCharWidths(text, textStyle),
        _totalTextWidth = _calcTotalWidth(text, textStyle),
        super(repaint: progress);

  static List<TextPainter> _buildCharPainters(String text, TextStyle style) {
    return List.generate(text.length, (i) {
      final tp = TextPainter(
        text: TextSpan(text: text[i], style: style),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      return tp;
    });
  }

  static List<double> _measureCharWidths(String text, TextStyle style) {
    final tp = TextPainter(textDirection: TextDirection.ltr);
    final letterSpacing = style.letterSpacing ?? 0;
    return List.generate(text.length, (i) {
      tp.text = TextSpan(text: text[i], style: style);
      tp.layout();
      return tp.width + letterSpacing;
    });
  }

  static double _calcTotalWidth(String text, TextStyle style) {
    final widths = _measureCharWidths(text, style);
    return widths.fold(0.0, (sum, w) => sum + w);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || text.isEmpty) return;

    // 1. Define the Path (RRect based on child size + padding)
    final Rect rect = Offset(-padding, -padding) &
        Size(size.width + padding * 2, size.height + padding * 2);
    final RRect rrect = borderRadius.toRRect(rect);
    final Path path = Path()..addRRect(rrect);

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final double pathLength = metric.length;
    if (pathLength == 0) return;

    // 2. Spacing logic
    const double gapBetweenRepeats = 40.0;
    int repeats = (pathLength / (_totalTextWidth + gapBetweenRepeats)).floor();
    repeats = math.max(1, repeats);
    double segmentLength = pathLength / repeats;

    for (int r = 0; r < repeats; r++) {
      double currentDist = (progress.value * pathLength) + (r * segmentLength);

      for (int i = 0; i < text.length; i++) {
        double actualDist = currentDist % pathLength;
        Tangent? tangent = metric.getTangentForOffset(actualDist);

        if (tangent != null) {
          final tp = _charPainters[i];
          canvas.save();
          canvas.translate(tangent.position.dx, tangent.position.dy);
          canvas.rotate(-tangent.angle);
          canvas.translate(0, -tp.height / 2);
          tp.paint(canvas, Offset(-tp.width / 2, 0));
          canvas.restore();
        }
        currentDist += _charWidths[i];
      }
    }
  }

  @override
  bool shouldRepaint(covariant ZoPathTextPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.padding != padding ||
        oldDelegate.progress != progress;
  }
}

