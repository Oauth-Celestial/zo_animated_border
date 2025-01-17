part of 'zo_animated_border.dart';

// ignore: must_be_immutable
class ZoAnimatedGradientBorder extends StatefulWidget {
  ZoAnimatedGradientBorder(
      {super.key,
      this.borderRadius = 0,
      this.glowOpacity = 1.0,
      this.duration = const Duration(seconds: 1),
      this.borderThickness = 1,
      required this.child,
      required this.gradientColor,
      this.shouldAnimate = true});

  /// Radius of the glow border
  final double borderRadius;

  /// How much the shadow should glow
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
  late final Tween<double> _animTween;
  late final Animation<double> _turnAnim;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animTween = Tween<double>(begin: 0.1, end: 2 * math.pi);
    _turnAnim = _animTween.animate(_animationController);
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
    return AnimatedBuilder(
        animation: _turnAnim,
        builder: (context, child) {
          return CustomPaint(
              painter: ZoGradientBorderPainter(
                  borderRadius: widget.borderRadius,
                  borderThickness: widget.borderThickness,
                  gradientColor: widget.gradientColor,
                  glowOpacity: widget.glowOpacity,
                  angle: _turnAnim.value),
              child: widget.child);
        });
  }
}
