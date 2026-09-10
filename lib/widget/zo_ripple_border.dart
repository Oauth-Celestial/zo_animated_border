import 'package:flutter/material.dart';

/// A widget that renders [ZoRippleBorder].
class ZoRippleBorder extends StatefulWidget {
  /// The [numberOfCircles] property.
  final int numberOfCircles;

  /// The [rippleColor] property.
  final Color rippleColor;

  /// The [minCircleSize] property.
  final double minCircleSize;

  /// The duration of the border animation.
  final Duration animationDuration;

  /// The child widget wrapped by the border.
  final Widget child;

  /// The border radius of the widget.
  final BorderRadius? borderRadius;

  /// Creates a [ZoRippleBorder] instance.
  const ZoRippleBorder({
    super.key,
    this.numberOfCircles = 3,
    this.rippleColor = Colors.amber,
    this.minCircleSize = 80,
    this.animationDuration = const Duration(seconds: 3),
    required this.child,
    this.borderRadius,
  });

  @override
  State<ZoRippleBorder> createState() => _ZoRippleBorderState();
}

class _ZoRippleBorderState extends State<ZoRippleBorder>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> scaleAnimations;
  late List<Animation<double>> opacityAnimations;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(widget.numberOfCircles, (i) {
      final controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      final delay = i * 0.3 * widget.animationDuration.inMilliseconds;
      Future.delayed(Duration(milliseconds: delay.toInt()), () {
        if (mounted) controller.repeat();
      });

      return controller;
    });

    scaleAnimations = controllers.map((controller) {
      return Tween<double>(begin: 0.7, end: 1.4).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        ),
      );
    }).toList();

    opacityAnimations = controllers.map((controller) {
      return Tween<double>(begin: 0.4, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ripples
          ...List.generate(widget.numberOfCircles, (i) {
            return AnimatedBuilder(
              animation: controllers[i],
              builder: (context, _) {
                final scale = scaleAnimations[i].value;
                final opacity = opacityAnimations[i].value;
                if (opacity <= 0) return const SizedBox.shrink();
                final size = widget.minCircleSize * scale;

                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: widget.rippleColor
                        .withValues(alpha: (0.5 * opacity).clamp(0.0, 1.0)),
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(size / 2),
                    boxShadow: [
                      BoxShadow(
                        color: widget.rippleColor
                            .withValues(alpha: (0.2 * opacity).clamp(0.0, 1.0)),
                        blurRadius: 20 * opacity,
                        spreadRadius: 8 * opacity,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          // Center child
          widget.child,
        ],
      ),
    );
  }
}
