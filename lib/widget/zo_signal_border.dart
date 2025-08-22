import 'package:flutter/material.dart';
import 'package:zo_animated_border/painter/zo_signal_painter.dart';

class ZoSignalBorder extends StatefulWidget {
  final List<Color> ringColors;
  final Widget child;

  Duration animationDuration;

  double borderRadius;
  double maxRadius;

  ZoSignalBorder(
      {super.key,
      required this.ringColors,
      required this.child,
      this.maxRadius = 180,
      this.animationDuration = const Duration(seconds: 3),
      this.borderRadius = 0});

  @override
  State<ZoSignalBorder> createState() => _ZoSignalBorderState();
}

class _ZoSignalBorderState extends State<ZoSignalBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();

    // _curvedAnimation =
    //     CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ZoSignalPainter(
          maxRadius: widget.maxRadius,
          borderRadius: widget.borderRadius,
          progress: _controller,
          ringColors: widget.ringColors,
        ),
        child: widget.child);
  }
}
