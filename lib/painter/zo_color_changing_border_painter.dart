import 'package:flutter/material.dart';

/// A custom painter that renders [ColorChangingPainter].
class ColorChangingPainter extends CustomPainter {
  /// The [animation] property.
  final Animation<double> animation;
  /// The thickness of the border.
  final double borderWidth;
  /// The corner radius of the clip cut.
  final double radius;
  /// The colors used in the border animation.
  final List<Color> colors;
  /// The [colorStops] property.
  final List<double>? colorStops;
  /// The length of each border segment.
  final double segmentLength;
  /// The [staticBorderColor] property.
  final Color staticBorderColor;

  /// Creates a [ColorChangingPainter] instance.
  ColorChangingPainter(
      {required this.animation,
      required this.borderWidth,
      required this.radius,
      required this.colors,
      required this.colorStops,
      required this.segmentLength,
      required this.staticBorderColor})
      : super(repaint: animation);

  Color _getInterpolatedColor(double progress) {
    final stops = colorStops ??
        List.generate(colors.length, (i) => i / (colors.length - 1));

    for (int i = 0; i < stops.length - 1; i++) {
      final start = stops[i];
      final end = stops[i + 1];
      if (progress >= start && progress <= end) {
        final t = (progress - start) / (end - start);
        return Color.lerp(colors[i], colors[i + 1], t)!;
      }
    }
    return colors.last;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rRect);

    final pm = path.computeMetrics().first;
    final totalLength = pm.length;

    final head = (animation.value * totalLength) % totalLength;
    final tail = (head + totalLength * segmentLength) % totalLength;

    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = staticBorderColor
      ..strokeWidth = borderWidth;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..color = _getInterpolatedColor(animation.value);

    Path glowingSegment;
    if (tail < head) {
      final part1 = pm.extractPath(head, totalLength);
      final part2 = pm.extractPath(0, tail);
      glowingSegment = Path()
        ..addPath(part1, Offset.zero)
        ..addPath(part2, Offset.zero);
    } else {
      glowingSegment = pm.extractPath(head, tail);
    }
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(glowingSegment, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
