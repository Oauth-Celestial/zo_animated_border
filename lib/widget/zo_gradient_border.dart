part of '../zo_animated_border.dart';

/// ![gradient_border (online-video-cutter com)](https://github.com/user-attachments/assets/785905a3-8836-4529-8d0b-50f5afbda666)
// ignore: must_be_immutable
class ZoAnimatedGradientBorder extends StatefulWidget {
  ZoAnimatedGradientBorder(
      {super.key,
      this.borderRadius = 0,
      this.glowOpacity = 0.5,
      this.duration = const Duration(seconds: 1),
      this.borderThickness = 1,
      required this.child,
      required this.gradientColor,
      this.shouldAnimate = true});

  /// Radius of the glow border
  final double borderRadius;

  /// How much the border should glow min 0.1 max 1.0
  final double glowOpacity;

  /// set the animation duration defaults to 1 second
  final Duration duration;

  /// border Thickness
  final double borderThickness;

  final Widget child;

  /// should animate the border
  final bool shouldAnimate;

  List<Color> gradientColor;

  @override
  State<ZoAnimatedGradientBorder> createState() =>
      _ZoAnimatedGradientBorderState();
}

class _ZoAnimatedGradientBorderState extends State<ZoAnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _turnAnim;

  @override
  void initState() {
    super.initState();
    if (widget.glowOpacity > 1.0 || widget.glowOpacity < 0.0) {
      throw Exception("Glow opacity should be between 0.0 and 1.0");
    }
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _turnAnim = Tween<double>(begin: 0.1, end: 2 * math.pi)
        .animate(_animationController);
    if (widget.shouldAnimate) {
      _animationController
        ..forward()
        ..repeat(reverse: false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ZoGradientBorderPainter(
            borderRadius: widget.borderRadius,
            borderThickness: widget.borderThickness,
            gradientColor: widget.gradientColor,
            glowOpacity: widget.glowOpacity,
            angle: _turnAnim),
        child: widget.child);
  }
}
