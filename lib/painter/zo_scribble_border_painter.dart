import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// A custom painter that renders [ZoScribblePainter].
class ZoScribblePainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The primary color of the border animation.
  final Color color;
  /// The [blur] property.
  final double blur;
  /// Optional custom stroke width for the border.
  final double strokeWidth;
  /// The border radius of the widget.
  final double borderRadius;

  /// Creates a [ZoScribblePainter] instance.
  ZoScribblePainter({
    required this.progress,
    this.color = Colors.amber,
    this.blur = 5,
    this.strokeWidth = 8,
    this.borderRadius = 20.0,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // Create the base smooth path (Rounded Rectangle)
    final RRect rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth),
      Radius.circular(borderRadius),
    );

    final Path basePath = Path()..addRRect(rrect);
    final Path jitteredPath = Path();

    // Use PathMetrics to walk along the rounded rect and add noise
    final PathMetric metric = basePath.computeMetrics().first;
    final double totalLength = metric.length;
    const double step = 2.0; // Small steps for smooth noise
    double currentProgress = progress.value;

    for (double i = 0; i < totalLength; i += step) {
      final Tangent? tangent = metric.getTangentForOffset(i);
      if (tangent == null) continue;

      double noise = sin(i * 0.05 + currentProgress * 2 * pi) * 1.5;
      noise += cos(i * 0.03 - currentProgress * pi) * 1.0;

      // Offset the point along its normal (perpendicular to the path)
      final Offset normal = Offset(-tangent.vector.dy, tangent.vector.dx);
      final Offset jitteredPoint = tangent.position + (normal * noise);

      if (i == 0) {
        jitteredPath.moveTo(jitteredPoint.dx, jitteredPoint.dy);
      } else {
        jitteredPath.lineTo(jitteredPoint.dx, jitteredPoint.dy);
      }
    }
    jitteredPath.close();

    final Paint glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    canvas.drawPath(
        jitteredPath, glowPaint..color = color.withValues(alpha: 0.3));

    canvas.drawPath(
        jitteredPath,
        glowPaint
          ..color = color.withValues(alpha: 0.6)
          ..strokeWidth = strokeWidth / 2);

    canvas.drawPath(
      jitteredPath,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / 4
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawPath(
      jitteredPath,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant ZoScribblePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
