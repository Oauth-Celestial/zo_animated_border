import 'package:flutter/material.dart';

/// Transforms the gradient to physically slide it left-to-right.
class SlideWipeGradientTransform extends GradientTransform {
  /// The progress of the slide animation from 0.0 to 1.0.
  final double progress;

  /// The number of segments.
  final int segmentCount;

  /// Creates a [SlideWipeGradientTransform] instance.
  const SlideWipeGradientTransform(this.progress, this.segmentCount);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double shiftX = bounds.width * segmentCount * progress;

    return Matrix4.identity()
      ..translateByDouble(shiftX, 0.0, 0.0, 1.0)
      ..scaleByDouble(segmentCount.toDouble(), 1.0, 1.0, 1.0);
  }
}

/// A custom painter that renders [ZoSequentialGlowBorderPainter].
class ZoSequentialGlowBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;

  /// The gradient palettes for sequential wiping.
  final List<List<Color>> gradientPalettes;

  /// The blur radius of the glow effect.
  final double glowRadius;

  /// The border width.
  final double borderWidth;

  /// The border radius of the widget.
  final BorderRadius borderRadius;

  /// Creates a [ZoSequentialGlowBorderPainter] instance.
  ZoSequentialGlowBorderPainter({
    required this.progress,
    required this.gradientPalettes,
    required this.glowRadius,
    required this.borderWidth,
    required this.borderRadius,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (gradientPalettes.isEmpty || size.isEmpty) return;

    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    // Dynamically calculate colors and stops to stitch all palettes side-by-side
    final List<Color> combinedColors = [];
    final List<double> combinedStops = [];
    final int n = gradientPalettes.length;

    for (int i = 0; i < n; i++) {
      List<Color> gColors = gradientPalettes[i];
      if (gColors.isEmpty) continue;
      if (gColors.length == 1) gColors = [gColors[0], gColors[0]];
      final int m = gColors.length;

      for (int j = 0; j < m; j++) {
        combinedColors.add(gColors[j]);

        double stop = (i / n) + (j / (m - 1)) * (1 / n);

        if (j == 0 && i > 0) {
          stop = (i / n) + 0.001;
        } else if (j == m - 1 && i < n - 1) {
          stop = ((i + 1) / n) - 0.001;
        }

        combinedStops.add(stop);
      }
    }

    if (combinedColors.isEmpty) return;

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: combinedColors,
      stops: combinedStops,
      tileMode: TileMode.repeated,
      transform: SlideWipeGradientTransform(progress.value, n),
    );

    final shader = gradient.createShader(rect);

    if (glowRadius > 0) {
      final glowPaint = Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius);

      canvas.drawRRect(rrect, glowPaint);
    }

    final sharpPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(rrect, sharpPaint);
  }

  @override
  bool shouldRepaint(covariant ZoSequentialGlowBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradientPalettes != gradientPalettes ||
        oldDelegate.glowRadius != glowRadius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
