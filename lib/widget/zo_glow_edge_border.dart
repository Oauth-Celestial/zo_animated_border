import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_glow_edge_border_painter.dart';

class ZOGlowingEdgeBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final double radius;
  final double snakeLength;
  final List<Color> gradientColors;

  const ZOGlowingEdgeBorder({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderWidth = 4.0,
    this.radius = 20.0,
    this.snakeLength = 120.0,
  });

  @override
  State<ZOGlowingEdgeBorder> createState() => _ZOGlowingEdgeBorderState();
}

class _ZOGlowingEdgeBorderState extends State<ZOGlowingEdgeBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZOGlowingEdgePainter(
        animation: _controller,
        borderWidth: widget.borderWidth,
        radius: widget.radius,
        snakeLength: widget.snakeLength,
        gradientColors: widget.gradientColors,
      ),
      child: widget.child,
    );
  }
}




// ZOGlowingEdgeBorder(
//           gradientColors: [Colors.purple, Colors.blue, Colors.cyan],
//           child: Padding(
//             padding: EdgeInsets.all(40.0),
//             child: Text(
//               'Custom Gradient',
//               style: TextStyle(color: Colors.white, fontSize: 24),
//             ),
//           ),