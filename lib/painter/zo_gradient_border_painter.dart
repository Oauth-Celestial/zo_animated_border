import 'package:flutter/material.dart';

/// A custom painter that renders [ZoGradientBorderPainter].
class ZoGradientBorderPainter extends CustomPainter {
  /// The rotation angle animation.
  final Animation<double> angle;

  /// The border radius of the widget.
  final double? borderRadius;

  /// The thickness of the border.
  final double borderThickness;

  /// The colors used in the border animation.
  final List<Color> gradientColor;

  /// The opacity of the outer glow effect.
  final double glowOpacity;

  /// The spread distance of the glow effect.
  final double glowSpread;

  /// Creates a [ZoGradientBorderPainter] instance.
  ZoGradientBorderPainter({
    required this.angle,
    this.borderRadius,
    this.borderThickness = 5,
    this.glowOpacity = 0.3,
    this.glowSpread = 5.0,
    required this.gradientColor,
  }) : super(repaint: angle);

  @override
  void paint(Canvas canvas, Size size) {
    if (gradientColor.isEmpty || size.isEmpty) return;

    final rect = Offset.zero & size;
    final radiiRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius ?? 0),
    );

    final colors = gradientColor.length == 1
        ? [gradientColor.first, gradientColor.first]
        : gradientColor;

    final gradient = LinearGradient(
      colors: colors,
      transform: GradientRotation(angle.value),
    );

    final shader = gradient.createShader(rect);

    // Efficient glow drawing controlled by glowSpread and glowOpacity
    if (glowOpacity > 0 && glowSpread > 0) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderThickness
        ..shader = shader
        ..colorFilter = ColorFilter.mode(
          Color.fromRGBO(255, 255, 255, glowOpacity.clamp(0.0, 1.0)),
          BlendMode.modulate,
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.solid, glowSpread);

      canvas.drawRRect(radiiRect, glowPaint);
    }

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness
      ..shader = shader;

    canvas.drawRRect(radiiRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant ZoGradientBorderPainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderThickness != borderThickness ||
        oldDelegate.glowOpacity != glowOpacity ||
        oldDelegate.glowSpread != glowSpread ||
        oldDelegate.gradientColor != gradientColor;
  }
}


