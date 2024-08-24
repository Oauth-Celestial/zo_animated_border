part of 'zo_animated_border.dart';

// ignore: must_be_immutable
class ZoAnimatedGradientBorder extends StatefulWidget {
  ZoAnimatedGradientBorder(
      {super.key,
      required this.width,
      required this.height,
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

  final double width;

  final double height;

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
  AnimationController? _controller;
  Animation<Alignment>? _topAlignmentAnimation;
  Animation<Alignment>? _bottomAlignmentAnimation;
  Color topColor = Colors.blue;

  Color bottomColor = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.gradientColor.isEmpty) {
      widget.gradientColor = [Colors.red, Colors.blue];
    }

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _initTopAnimation();
    _initBottomAnimation();
    if (widget.shouldAnimate) {
      _controller?.repeat();
    }

    topColor = widget.gradientColor.first;
    bottomColor = widget.gradientColor.last;
  }

  /// Sets the alignment animation for bottom color (Last color in the list)
  void _initBottomAnimation() {
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1)
    ]).animate(_controller!);
  }

  /// Sets the alignment animation for top color (first color in the list)
  void _initTopAnimation() {
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1)
    ]).animate(_controller!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            widget.child != null
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.borderRadius)),
                    child: widget.child,
                  )
                : const SizedBox.shrink(),
            ClipPath(
              clipper: _BorderCutClipper(
                  radius: widget.borderRadius,
                  thickness: widget.borderThickness),
              child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (context, _) {
                    return Stack(
                      children: [
                        /// Creates the shadow with the first color in list
                        Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              boxShadow: [
                                BoxShadow(
                                    color: topColor
                                        .withOpacity(widget.glowOpacity),
                                    offset: Offset.zero,
                                    blurRadius: widget.blurRadius,
                                    spreadRadius: widget.spreadRadius)
                              ]),
                        ),

                        /// Creates the shadow with the last color in list
                        Align(
                          alignment: _bottomAlignmentAnimation!.value,
                          child: Container(
                            width: constraints.maxWidth * 0.95,
                            height: constraints.maxHeight * 0.95,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(widget.borderRadius)),
                                boxShadow: [
                                  BoxShadow(
                                      color: bottomColor
                                          .withOpacity(widget.glowOpacity),
                                      offset: Offset.zero,
                                      blurRadius: widget.blurRadius,
                                      spreadRadius: widget.spreadRadius)
                                ]),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(widget.borderRadius)),
                              gradient: LinearGradient(
                                  begin: _topAlignmentAnimation!.value,
                                  end: _bottomAlignmentAnimation!.value,
                                  colors: widget.gradientColor)),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}

/// Responsible for clipping the widget and creating the border style
class _BorderCutClipper extends CustomClipper<Path> {
  double thickness;
  double radius;
  _BorderCutClipper({
    required this.thickness,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
        -size.width, -size.width, size.width * 2, size.height * 2);
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    final borderPath = Path();
    borderPath.fillType = PathFillType.evenOdd;
    borderPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(thickness, thickness, width, height),
        Radius.circular(radius - thickness)));
    borderPath.addRect(rect);

    return borderPath;
  }

  @override
  bool shouldReclip(_BorderCutClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}
