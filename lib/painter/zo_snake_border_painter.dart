import 'package:flutter/material.dart';

import 'dart:ui' as ui;

/// A custom painter that renders [ZoSnakeBorderPainter].
class ZoSnakeBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The thickness of the border.
  final double borderWidth;
  /// The [colorFrom] property.
  final Color colorFrom;
  /// The [colorTo] property.
  final Color colorTo;
  /// The [staticBorderColor] property.
  final Color staticBorderColor;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// The opacity of the outer glow effect.
  final double glowOpacity;
  /// The spread of the glow effect.
  final double glowSpread;

  /// Creates a [ZoSnakeBorderPainter] instance.
  ZoSnakeBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.colorFrom,
    required this.colorTo,
    required this.staticBorderColor,
    required this.borderRadius,
    this.glowOpacity = 0.8,
    this.glowSpread = 6.0,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    // Draw static border
    final staticPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = staticBorderColor;
    canvas.drawRRect(rrect, staticPaint);

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final pathMetrics = metrics.first;
    final pathLength = pathMetrics.length;
    if (pathLength == 0) return;

    // Adjust the animation to prevent the jump
    final animationProgress = progress.value % 1.0;
    final start = animationProgress * pathLength;
    final end = (start + pathLength / 4) % pathLength;

    Path extractPath;
    if (end > start) {
      extractPath = pathMetrics.extractPath(start, end);
    } else {
      extractPath = pathMetrics.extractPath(start, pathLength);
      extractPath.addPath(pathMetrics.extractPath(0, end), Offset.zero);
    }

    // Calculate gradient start and end points
    final gradientStart =
        pathMetrics.getTangentForOffset(start)?.position ?? Offset.zero;
    final gradientEnd =
        pathMetrics.getTangentForOffset(end)?.position ?? Offset.zero;

    final snakeShader = ui.Gradient.linear(
      gradientStart,
      gradientEnd,
      [
        colorTo.withValues(alpha: 0.0),
        colorTo,
        colorFrom,
      ],
      const [0.0, 0.3, 1.0],
    );

    // Single-pass glow
    if (glowOpacity > 0 && glowSpread > 0) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..shader = ui.Gradient.linear(
          gradientStart,
          gradientEnd,
          [colorTo, colorFrom],
          const [0.3, 1.0],
        )
        ..colorFilter = ColorFilter.mode(
          Color.fromRGBO(255, 255, 255, glowOpacity.clamp(0.0, 1.0)),
          BlendMode.modulate,
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.solid, glowSpread);

      canvas.drawPath(extractPath, glowPaint);
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = snakeShader;

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant ZoSnakeBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.colorFrom != colorFrom ||
        oldDelegate.colorTo != colorTo ||
        oldDelegate.staticBorderColor != staticBorderColor ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.glowOpacity != glowOpacity ||
        oldDelegate.glowSpread != glowSpread;
  }
}

