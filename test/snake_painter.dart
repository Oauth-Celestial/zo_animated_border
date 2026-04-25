import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: SnakeBorderTextField()),
      ),
    ),
  );
}

class SnakeBorderTextField extends StatefulWidget {
  const SnakeBorderTextField({super.key});

  @override
  State<SnakeBorderTextField> createState() => _SnakeBorderTextFieldState();
}

class _SnakeBorderTextFieldState extends State<SnakeBorderTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 0.5,
        ).chain(CurveTween(curve: Curves.bounceIn)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.5,
          end: 0.8,
        ).chain(CurveTween(curve: Curves.slowMiddle)),
        weight: 4,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.slowMiddle)),
        weight: 2,
      ),
    ]).animate(_controller);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward(from: 0); // snake keeps moving
        _controller.repeat();
      } else {
        _controller.stop();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _focusNode.hasFocus
              ? SnakeBorderPainter(progress: _animation.value)
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              focusNode: _focusNode,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SnakeBorderPainter extends CustomPainter {
  final double progress;
  SnakeBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(40)));

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.greenAccent, Colors.yellowAccent],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Measure path
    for (final metric in path.computeMetrics()) {
      final length = metric.length;
      const snakeLength = 80.0; // length of moving segment
      final start = (length * progress);
      final end = (start + snakeLength) % length;

      Path extract;
      if (end > start) {
        // normal case
        extract = metric.extractPath(start, end);
      } else {
        extract = Path()
          ..addPath(metric.extractPath(start, length), Offset.zero)
          ..addPath(metric.extractPath(0, end), Offset.zero);
      }

      canvas.drawPath(extract, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SnakeBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
