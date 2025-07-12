import 'package:flutter/material.dart';

class ZOGlowingEdgePainter extends CustomPainter {
  final Animation<double> animation;
  final double borderWidth;
  final double radius;
  final double snakeLength;
  final List<Color> gradientColors;

  ZOGlowingEdgePainter({
    required this.animation,
    required this.borderWidth,
    required this.radius,
    required this.snakeLength,
    required this.gradientColors,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(borderWidth / 2),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      final totalLength = metric.length;
      final progress = animation.value * totalLength;

      final start = progress;
      final end = progress + snakeLength;

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
