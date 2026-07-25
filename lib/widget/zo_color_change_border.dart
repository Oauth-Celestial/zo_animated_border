import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_color_changing_border_painter.dart';

/// ![colorborder](https://github.com/user-attachments/assets/d2016016-0da1-487e-859e-63cad3b85b56)
class ZoColorChangingBorder extends StatefulWidget {
  /// The child widget wrapped by the border.
  final Widget child;
  /// The thickness of the border.
  final double borderWidth;
  /// The border radius of the widget.
  final double borderRadius;
  // value can be set between 0.0 - 1.0
  /// The length of each border segment.
  final double segmentLength;
  /// The duration of the border animation.
  final Duration animationDuration;
  /// The colors used in the border animation.
  final List<Color> colors;
  //  value in list can be set from 0.1 to 1.0  e.g[0.1,0.6,1.0]
  /// The [colorStops] property.
  final List<double>? colorStops;
  /// The [staticBorderColor] property.
  final Color staticBorderColor;
  /// The animation curve.
  final Curve animationCurve;

  /// Creates a [ZoColorChangingBorder] instance.
  const ZoColorChangingBorder(
      {super.key,
      required this.child,
      this.borderWidth = 4,
      this.borderRadius = 12,
      this.segmentLength = 0.1,
      required this.colors,
      this.animationDuration = const Duration(seconds: 3),
      this.colorStops,
      this.staticBorderColor = Colors.transparent,
      this.animationCurve = Curves.linear});

  @override
  State<ZoColorChangingBorder> createState() => _ZoColorChangingBorderState();
}

class _ZoColorChangingBorderState extends State<ZoColorChangingBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Animation<double>? _curveAnimation;
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
      duration: widget.animationDuration,
    )..repeat();

    _curveAnimation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
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
        animation: _curveAnimation!,
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
