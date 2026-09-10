part of '../zo_animated_border.dart';

/// ![gradient_border (online-video-cutter com)](https://github.com/user-attachments/assets/785905a3-8836-4529-8d0b-50f5afbda666)
class ZoAnimatedGradientBorder extends StatefulWidget {
  /// Radius of the glow border
  final double borderRadius;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;

  /// The spread distance/radius of the glow effect
  final double glowSpread;

  /// set the animation duration defaults to 1 second
  final Duration animationDuration;

  /// border Thickness
  final double borderThickness;

  /// The child widget wrapped by the border.
  final Widget child;

  /// should animate the border
  final bool shouldAnimate;

  /// The list of colors used for the gradient border.
  final List<Color> gradientColor;

  /// The animation curve for border rotation.
  final Curve animationCurve;

  /// Creates a [ZoAnimatedGradientBorder] widget.
  const ZoAnimatedGradientBorder(
      {super.key,
      this.borderRadius = 0,
      this.glowOpacity = 0.5,
      this.glowSpread = 5.0,
      this.animationDuration = const Duration(seconds: 1),
      this.borderThickness = 1,
      this.animationCurve = Curves.linear,
      required this.child,
      required this.gradientColor,
      this.shouldAnimate = true});

  @override
  State<ZoAnimatedGradientBorder> createState() =>
      _ZoAnimatedGradientBorderState();
}

class _ZoAnimatedGradientBorderState extends State<ZoAnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late Animation<double> _turnAnim;

  @override
  void initState() {
    super.initState();
    if (widget.glowOpacity > 1.0 || widget.glowOpacity < 0.0) {
      throw Exception("Glow opacity should be between 0.0 and 1.0");
    }
    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);

    _turnAnim = Tween<double>(begin: 0.1, end: 2 * math.pi).animate(
        CurvedAnimation(
            parent: _animationController, curve: widget.animationCurve));
    if (widget.shouldAnimate) {
      _animationController.repeat(reverse: false);
    }
  }

  @override
  void didUpdateWidget(covariant ZoAnimatedGradientBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = widget.animationDuration;
    }
    if (widget.animationCurve != oldWidget.animationCurve) {
      _turnAnim = Tween<double>(begin: 0.1, end: 2 * math.pi).animate(
          CurvedAnimation(
              parent: _animationController, curve: widget.animationCurve));
    }
    if (widget.shouldAnimate != oldWidget.shouldAnimate) {
      if (widget.shouldAnimate) {
        _animationController.repeat(reverse: false);
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
          painter: ZoGradientBorderPainter(
              borderRadius: widget.borderRadius,
              borderThickness: widget.borderThickness,
              gradientColor: widget.gradientColor,
              glowOpacity: widget.glowOpacity,
              glowSpread: widget.glowSpread,
              angle: _turnAnim),
          child: widget.child),
    );
  }
}
