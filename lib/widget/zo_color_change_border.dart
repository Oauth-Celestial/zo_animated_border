import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_color_changing_border_painter.dart';

/// ![colorborder](https://github.com/user-attachments/assets/d2016016-0da1-487e-859e-63cad3b85b56)
class ZoColorChangingBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  // value can be set between 0.0 - 1.0
  final double segmentLength;
  final Duration duration;
  final List<Color> colors;
  //  value in list can be set from 0.1 to 1.0  e.g[0.1,0.6,1.0]
  final List<double>? colorStops;
  final Color staticBorderColor;

  const ZoColorChangingBorder({
    super.key,
    required this.child,
    this.borderWidth = 4,
    this.borderRadius = 12,
    this.segmentLength = 0.1,
    required this.colors,
    this.duration = const Duration(seconds: 3),
    this.colorStops,
    this.staticBorderColor = Colors.transparent,
  });

  @override
  State<ZoColorChangingBorder> createState() => _ZoColorChangingBorderState();
}

class _ZoColorChangingBorderState extends State<ZoColorChangingBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double borderLength = 0;

  @override
  void initState() {
    super.initState();
    if (widget.segmentLength >= 1) {
      borderLength = 0.9999;
    } else {
      borderLength = widget.segmentLength;
    }

    if (widget.colorStops != null) {
      if (widget.colorStops!.isEmpty) {
        throw Exception("Colors stops cannot be empty");
      }

      if (widget.colorStops!.length != widget.colors.length) {
        throw Exception(
            "Colors length and color stops should be of same length");
      }
    }
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
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
        segmentLength: borderLength,
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
