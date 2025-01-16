part of 'zo_animated_border.dart';

// ignore: must_be_immutable
class ZoAnimatedGradientBorder extends StatefulWidget {
  ZoAnimatedGradientBorder(
      {super.key,
      this.borderRadius = 30,
      this.blurRadius = 30,
      this.spreadRadius = 1,
      this.glowOpacity = 0.3,
      this.duration = const Duration(milliseconds: 600),
      this.borderThickness = 1,
      this.child,
      required this.gradientColor,
      this.shouldAnimate = true});

  /// Radius of the glow border
  final double borderRadius;

  /// How much the shadow should be blurred
  final double blurRadius;

  /// How much the shadow should spread
  final double spreadRadius;

  /// How much the shadow should glow
  final double glowOpacity;

  /// set the animation duration defaults to  600 milliseconds
  final Duration duration;

  /// border Thickness
  final double borderThickness;

  final Widget? child;

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
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animTween = Tween<double>(begin: 0.1, end: 2 * math.pi);
    _turnAnim = _animTween.animate(_animationController);

    _animationController
      ..forward()
      ..repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeProviderWidget(builder: (context, size) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: AnimatedBuilder(
            animation: _turnAnim,
            child: widget.child,
            builder: (context, child) {
              return CustomPaint(
                  painter: BorderPainter(angle: _turnAnim.value),
                  child: child!);
            }),
      );
    });
  }
}
