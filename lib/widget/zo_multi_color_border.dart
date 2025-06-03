import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_multi_color_border.dart';

class ZoMultiColorBorder extends StatefulWidget {
  final double borderRadius;

  final double gapLength;
  final double strokeWidth;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  final List<Color> colors;
  bool animate;
  ZoMultiColorBorder(
      {super.key,
      required this.child,
      this.borderRadius = 0,
      this.gapLength = 0,
      this.strokeWidth = 3,
      this.animate = true,
      this.padding,
      this.colors = const [Colors.blue, Colors.black]});

  @override
  State<ZoMultiColorBorder> createState() => _ZoMultiColorBorderState();
}

class _ZoMultiColorBorderState extends State<ZoMultiColorBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    if (widget.animate) {
      _controller.repeat();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: CustomPaint(
          painter: ZoMultiColorBorderPainter(
              progress: _controller,
              colors: widget.colors,
              borderRadius: widget.borderRadius,
              borderWidth: widget.strokeWidth,
              gapLength: widget.gapLength),
          child: widget.child),
    );
  }
}
