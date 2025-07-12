import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_color_changing_border_painter.dart';

class ZoColorChangingBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  double segmentLength; // 0.0 - 1.0 (fraction of perimeter)
  final List<Color> colors;
  final List<double>? colorStops;
  final Color staticBorderColor;

  ZoColorChangingBorder({
    super.key,
    required this.child,
    this.borderWidth = 4,
    this.borderRadius = 12,
    this.segmentLength = 0.1,
    required this.colors,
    this.colorStops,
    this.staticBorderColor = Colors.transparent,
  });

  @override
  State<ZoColorChangingBorder> createState() => _ZoColorChangingBorderState();
}

class _ZoColorChangingBorderState extends State<ZoColorChangingBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.segmentLength >= 1) {
      widget.segmentLength = 0.9999;
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ColorChangingPainter(
        animation: _controller,
        staticBorderColor: widget.staticBorderColor,
        borderWidth: widget.borderWidth,
        radius: widget.borderRadius,
        colors: widget.colors,
        colorStops: widget.colorStops,
        segmentLength: widget.segmentLength,
      ),
      child: widget.child,
    );
  }
}

// ZOGlowingEdgeBorder(
//             radius: 100,
//             borderWidth: 4,
//             snakeLength: 0.12,
//             colors: [Colors.cyan, Colors.purple, Colors.orange],
//             colorStops: [0.0, 0.5, 1.0],
//             child: SizedBox(
//               width: 200,
//               height: 200,
//               child: Center(
//                 child: Text(
//                   'Snake Glow',
//                   style: TextStyle(color: Colors.white, fontSize: 22),
//                 ),
//               ),
//             ),
//           ),
