import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0C12),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBorderBox(isRadial: false),
            SizedBox(height: 40),
            AnimatedBorderBox(isRadial: true),
          ],
        ),
      ),
    );
  }
}

class AnimatedBorderBox extends StatefulWidget {
  final bool isRadial;
  const AnimatedBorderBox({super.key, required this.isRadial});

  @override
  State<AnimatedBorderBox> createState() => _AnimatedBorderBoxState();
}

class _AnimatedBorderBoxState extends State<AnimatedBorderBox>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(); // continuous loop
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: BorderPainter(
            progress: controller.value,
            isRadial: widget.isRadial,
          ),
          child: Container(
            width: 250,
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              "Flutter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}

class BorderPainter extends CustomPainter {
  final double progress;
  final bool isRadial;

  BorderPainter({required this.progress, required this.isRadial});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const strokeWidth = 6.0;

    final innerRect = rect.deflate(strokeWidth / 2);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if (isRadial) {
      paint.shader = _radialShader(rect);
    } else {
      paint.shader = _conicLikeShader(rect);
    }

    canvas.drawRect(innerRect, paint);
  }

  // Fake conic gradient using sweep gradient
  Shader _conicLikeShader(Rect rect) {
    return SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(progress * 2 * pi),
      colors: const [
        Color.fromRGBO(168, 239, 255, 0.1),
        Color.fromRGBO(168, 239, 255, 1),
        Color.fromRGBO(168, 239, 255, 1),
        Color.fromRGBO(168, 239, 255, 0.1),
      ],
      stops: const [0.0, 0.1, 0.15, 0.25],
    ).createShader(rect);
  }

  // Moving radial highlight
  Shader _radialShader(Rect rect) {
    final x = _lerpSequence(progress, [1, 1, 0.5, 0, 0.5]);
    final y = _lerpSequence(progress, [0.5, 1, 1, 0.5, 0]);

    return RadialGradient(
      center: Alignment(x * 2 - 1, y * 2 - 1),
      radius: 1.2,
      colors: const [
        Color.fromRGBO(168, 239, 255, 1),
        Color.fromRGBO(168, 239, 255, 1),
        Color.fromRGBO(168, 239, 255, 0.1),
      ],
      stops: const [0.0, 0.1, 0.4],
    ).createShader(rect);
  }

  double _lerpSequence(double t, List<double> values) {
    final segment = 1 / values.length;
    int index = (t / segment).floor();
    index = index.clamp(0, values.length - 2);

    final localT = (t - segment * index) / segment;
    return lerpDouble(values[index], values[index + 1], localT)!;
  }

  @override
  bool shouldRepaint(covariant BorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isRadial != isRadial;
  }
}
