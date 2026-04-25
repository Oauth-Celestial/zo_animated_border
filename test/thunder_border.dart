import 'dart:math';

import 'package:flutter/material.dart';

class ThunderBorderExample extends StatefulWidget {
  const ThunderBorderExample({super.key});

  @override
  State<ThunderBorderExample> createState() => _ThunderBorderExampleState();
}

class _ThunderBorderExampleState extends State<ThunderBorderExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ThunderBorderPainter(_controller.value),
                  size: const Size(300, 100),
                );
              },
            ),
            Container(
              width: 300,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Your Content",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThunderBorderPainter extends CustomPainter {
  final double animationValue;

  ThunderBorderPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.purpleAccent.withValues(alpha: 0.8);

    final Path borderPath = Path();
    final Random random = Random();

    // Generate a thunder effect along the border
    double offset = 0.0;
    for (double x = 0; x <= size.width; x += 10) {
      offset = random.nextDouble() * 6 -
          3; // Randomize y-offset for the thunder effect
      borderPath.lineTo(x, offset);
    }
    for (double y = 0; y <= size.height; y += 10) {
      offset = random.nextDouble() * 6 - 3;
      borderPath.lineTo(size.width + offset, y);
    }
    for (double x = size.width; x >= 0; x -= 10) {
      offset = random.nextDouble() * 6 - 3;
      borderPath.lineTo(x, size.height + offset);
    }
    for (double y = size.height; y >= 0; y -= 10) {
      offset = random.nextDouble() * 6 - 3;
      borderPath.lineTo(offset, y);
    }

    // Draw a glowing animated border
    paint.shader = LinearGradient(
      colors: const [
        Colors.purpleAccent,
        Colors.blueAccent,
        Colors.purpleAccent,
      ],
      stops: [0.0, animationValue, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(borderPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
