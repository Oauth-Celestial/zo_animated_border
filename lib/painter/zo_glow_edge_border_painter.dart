import 'package:flutter/material.dart';

/// A custom painter that renders [ZOGlowingEdgePainter].
class ZOGlowingEdgePainter extends CustomPainter {
  /// The [animation] property.
  final Animation<double> animation;
  /// The thickness of the border.
  final double borderWidth;
  /// The border radius of the widget.
  final double borderRadius;
  /// The [edgeLength] property.
  final double edgeLength;
  /// The colors used in the border animation.
  final List<Color> gradientColors;

  /// Creates a [ZOGlowingEdgePainter] instance.
  ZOGlowingEdgePainter({
    required this.animation,
    required this.borderWidth,
    required this.borderRadius,
    required this.edgeLength,
    required this.gradientColors,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(borderWidth / 2),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      final totalLength = metric.length;
      final progress = animation.value * totalLength;

      final start = progress;
      final end = progress + edgeLength;

      Path snakePath;

      if (end <= totalLength) {
        snakePath = metric.extractPath(start, end);
      } else {
        final firstPart = metric.extractPath(start, totalLength);
        final secondPart = metric.extractPath(0, end - totalLength);

        snakePath = Path()
          ..addPath(firstPart, Offset.zero)
          ..addPath(secondPart, Offset.zero);
      }

      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            ...gradientColors,
            Colors.transparent,
          ],
          stops: _buildStops(gradientColors.length + 2),
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(snakePath, paint);
    }
  }

  List<double> _buildStops(int count) {
    // Evenly space the stops between 0 and 1
    return List.generate(count, (i) => i / (count - 1));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
