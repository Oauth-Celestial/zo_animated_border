import 'package:flutter/material.dart';
import 'package:zo_animated_border/util/zo_path_helper.dart';

/// A custom painter that renders [ZoMultiColorBorderPainter].
class ZoMultiColorBorderPainter extends CustomPainter {
  /// The colors used in the border animation.
  final List<Color> colors;
  /// The border radius of the widget.
  final double borderRadius;
  /// The thickness of the border.
  final double borderWidth;
  /// The length of the gap.
  final double gapLength;
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double>? progress;

  /// Creates a [ZoMultiColorBorderPainter] instance.
  ZoMultiColorBorderPainter({
    required this.colors,
    this.borderRadius = 8.0,
    this.borderWidth = 4.0,
    this.gapLength = 0,
    this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || colors.isEmpty) return;

    int segments = colors.length;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWidth;

    final path =
        ZoPathHelper.createRRectPath(size, BorderRadius.circular(borderRadius));
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    for (final p in metrics) {
      double totalLength = p.length;
      if (totalLength == 0) continue;
      double segmentLength = (totalLength - gapLength * segments) / segments;
      if (segmentLength <= 0) continue;

      double progressOffset = totalLength * (progress?.value ?? 0);

      for (int i = 0; i < segments; i++) {
        paint.color = colors[i];
        double start = (segmentLength + gapLength) * i + progressOffset;
        double end = start + segmentLength;

        final drawPath = ZoPathHelper.extractLoopedSubPath(p, start, end);
        canvas.drawPath(drawPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ZoMultiColorBorderPainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.progress != progress;
  }
}

