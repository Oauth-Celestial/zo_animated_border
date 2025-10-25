import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBorder extends StatefulWidget {
  const AnimatedGradientBorder({super.key});

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final gradientColors = const [
    Color(0xfffb0094),
    Color(0xff0000ff),
    Color(0xff00ff00),
    Color(0xffffff00),
    Color(0xffff0000),
    Color(0xfffb0094),
    Color(0xff0000ff),
    Color(0xff00ff00),
    Color(0xffffff00),
    Color(0xffff0000),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
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
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _AnimatedBorderPainter(
                animationValue: _controller.value,
                colors: gradientColors,
              ),
              child: Container(
                width: 500,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Color(0xFF272727)],
                  ),
                ),
                child: const Text(
                  "Flutter Border Animation",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedBorderPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;

  _AnimatedBorderPainter({required this.animationValue, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      colors: colors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      transform: GradientRotation(animationValue * 2 * math.pi),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final borderRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    // Outer glow effect like CSS :after blur
    final glowPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRRect(borderRect, glowPaint);
    canvas.drawRRect(borderRect, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedBorderPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

void main() {
  runApp(const MaterialApp(home: AnimatedGradientBorder()));
}
