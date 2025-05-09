import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_multi_color_border.dart';

class ZoMultiColorBorder extends StatelessWidget {
  final double borderRadius;

  final double gapLength;
  final double strokeWidth;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  final List<Color> colors;
  const ZoMultiColorBorder(
      {super.key,
      required this.child,
      this.borderRadius = 0,
      this.gapLength = 0,
      this.strokeWidth = 3,
      this.padding,
      this.colors = const [Colors.blue, Colors.black]});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: CustomPaint(
          painter: ZoMultiColorBorderPainter(
              colors: colors,
              borderRadius: borderRadius,
              borderWidth: strokeWidth,
              gapLength: gapLength),
          child: child),
    );
  }
}
