import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/size_provider_widget.dart';

enum ZoPulsatingBorderType { pulse, radarPulse }

/// ![pulse (online-video-cutter com)](https://github.com/user-attachments/assets/98c2d962-b38d-4d0c-8865-b3641db69e97)
class ZoPulsatingBorder extends StatefulWidget {
  const ZoPulsatingBorder(
      {super.key,
      required this.child,
      this.layerCount = 2,
      this.borderRadius,
      this.pulseColor = Colors.black,
      this.animationDuration = const Duration(seconds: 2),
      this.type = ZoPulsatingBorderType.pulse,
      this.animationCurve = Curves.easeOut});

  final double layerCount;
  final Widget child;
  final BorderRadius? borderRadius;
  final Color pulseColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final ZoPulsatingBorderType? type;
  @override
  ZoPulsatingBorderState createState() => ZoPulsatingBorderState();
}

class ZoPulsatingBorderState extends State<ZoPulsatingBorder>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
          parent: _animationController!, curve: widget.animationCurve),
    );
    _animationController?.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeProviderWidget(builder: (context, size) {
      return AnimatedBuilder(
        animation: _animation!,
        builder: (context, _) {
          if (widget.type == ZoPulsatingBorderType.pulse) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                border: Border.all(
                    color: widget.pulseColor.withValues(alpha: 255),
                    width: 1.0),
                // shape: BoxShape.rectangle,
                boxShadow: [
                  for (int i = 1; i <= widget.layerCount; i++)
                    BoxShadow(
                      color: widget.pulseColor
                          .withValues(alpha: _animationController!.value / 2),
                      spreadRadius: _animation!.value * i,
                    )
                ],
              ),
              child: widget.child,
            );
          } else {
            return Stack(
              children: [
                ...List.generate(widget.layerCount.toInt() + 1, (index) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.0 + (index * 0.12))
                        .animate(
                      CurvedAnimation(
                        parent: _animationController!,
                        curve: Interval(0.0, 1.0, curve: widget.animationCurve),
                      ),
                    ),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius,
                        border:
                            Border.all(color: widget.pulseColor, width: 1.0),
                      ),
                    ),
                  );
                }),
                widget.child,
              ],
            );
          }
        },
      );
    });
  }
}
