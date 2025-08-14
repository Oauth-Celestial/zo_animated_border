import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: RippleBackground(
            ringColors: [
              Colors.yellow,
              Colors.orange,
              Colors.red,
              Colors.purple,
              Colors.blue,
            ],
          ),
        ),
      ),
    );
  }
}

class RippleBackground extends StatefulWidget {
  final List<Color> ringColors;

  const RippleBackground({super.key, required this.ringColors});

  @override
  State<RippleBackground> createState() => _RippleBackgroundState();
}

class _RippleBackgroundState extends State<RippleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: RipplePainter(
            progress: _controller.value,
            ringColors: widget.ringColors,
          ),
          child: const SizedBox(
            width: 300,
            height: 300,
            child: Center(
              child: Text(
                "Hola!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RipplePainter extends CustomPainter {
  final double progress;
  final List<Color> ringColors;

  RipplePainter({required this.progress, required this.ringColors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const maxRadius = 180.0;

    for (int i = 0; i < ringColors.length; i++) {
      double rippleProgress = (progress + (i / ringColors.length)) % 1.0;
      double radius = rippleProgress * maxRadius;

      final paint = Paint()
        ..color = ringColors[i].withOpacity(1.0 - rippleProgress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringColors != ringColors;
  }
}
