import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RevolvingBorderWithFlare extends StatefulWidget {
  @override
  _RevolvingBorderWithFlareState createState() =>
      _RevolvingBorderWithFlareState();
}

class _RevolvingBorderWithFlareState extends State<RevolvingBorderWithFlare>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Adjust speed here
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
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: RevolvingBorderPainter(_controller.value),
                  size: const Size(300, 300),
                );
              },
            ),
            Container(
              width: 250,
              height: 250,
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

class RevolvingBorderPainter extends CustomPainter {
  final double progress; // Animation progress (0.0 to 1.0)

  RevolvingBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 8.0;
    final double radius = size.width / 2 - strokeWidth;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw the revolving border
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.purpleAccent;

    double startAngle = progress * 2 * pi; // Start angle of the arc
    double sweepAngle = 2 * pi * 0.9; // Arc length (90% of the circle)

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      borderPaint,
    );

    // Draw the silver flare effect at the endpoint
    final Paint flarePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.8),
          Colors.grey.withOpacity(0.4),
          Colors.transparent,
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            center.dx + radius * cos(startAngle + sweepAngle),
            center.dy + radius * sin(startAngle + sweepAngle),
          ),
          radius: 20,
        ),
      );

    canvas.drawCircle(
      Offset(
        center.dx + radius * cos(startAngle + sweepAngle),
        center.dy + radius * sin(startAngle + sweepAngle),
      ),
      20, // Flare size
      flarePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
