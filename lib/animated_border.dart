part of 'zo_animated_border.dart';

class ZoAnimatedGradientBorder extends StatefulWidget {
  ZoAnimatedGradientBorder({
    super.key,
    this.radius = 10,
    this.blurRadius = 10,
    this.spreadRadius = 1,
    this.topColor = Colors.red,
    this.bottomColor = Colors.blue,
    this.glowOpacity = 0.3,
    this.duration = const Duration(milliseconds: 600),
    this.thickness = 3,
    this.child,
  });

  /// Radius of the glow border
  final double radius;

  final double blurRadius;

  final double spreadRadius;

  final Color topColor;

  final Color bottomColor;

  final double glowOpacity;

  final Duration duration;

  final double thickness;

  final Widget? child;

  @override
  State<ZoAnimatedGradientBorder> createState() =>
      _ZoAnimatedGradientBorderState();
}

class _ZoAnimatedGradientBorderState extends State<ZoAnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Alignment>? _topAlignmentAnimation;
  Animation<Alignment>? _bottomAlignmentAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _initTopAnimation();
    _initBottomAnimation();

    _controller?.repeat();
  }

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
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          widget.child != null
              ? ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                  child: widget.child,
                )
              : SizedBox.shrink(),
          ClipPath(
            clipper: _BorderCutClipper(
                radius: widget.radius, thickness: widget.thickness),
            child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, _) {
                  return Stack(
                    children: [
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                  color: widget.topColor
                                      .withOpacity(widget.glowOpacity),
                                  offset: Offset.zero,
                                  blurRadius: widget.blurRadius,
                                  spreadRadius: widget.spreadRadius)
                            ]),
                      ),
                      Align(
                        alignment: _bottomAlignmentAnimation!.value,
                        child: Container(
                          width: constraints.maxWidth * 0.95,
                          height: constraints.maxHeight * 0.95,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(widget.radius)),
                              boxShadow: [
                                BoxShadow(
                                    color: widget.bottomColor
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
                                Radius.circular(widget.radius)),
                            gradient: LinearGradient(
                                begin: _topAlignmentAnimation!.value,
                                end: _bottomAlignmentAnimation!.value,
                                colors: [widget.topColor, widget.bottomColor])),
                      ),
                    ],
                  );
                }),
          ),
        ],
      );
    });
  }
}

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
    // TODO: implement shouldReclip
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}
