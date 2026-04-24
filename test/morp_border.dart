import 'dart:math';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 40),

              // 🔹 Example 1: Single color (no gradient)
              MorphingContainer(
                width: 50,
                height: 50,
                colors: [Colors.grey],
              ),

              SizedBox(height: 40),

              // 🔹 Example 2: Multiple colors → auto gradient
              MorphingContainer(
                width: 240,
                height: 180,
                colors: [Colors.blue, Colors.purple],
                child: Center(
                  child: Text(
                    "Auto Gradient",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // 🔹 Example 3: Explicit gradient (overrides colors)
              MorphingContainer(
                width: 260,
                height: 180,
                colors: [Colors.red], // ignored
                gradient: RadialGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                ),
                child: Center(
                  child: Text(
                    "Radial Gradient",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // 🔹 Example 4: Sweep gradient
              MorphingContainer(
                width: 260,
                height: 180,
                gradient: SweepGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.red,
                  ],
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class MorphingContainer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;

  final List<Color>? colors;
  final Gradient? gradient;

  const MorphingContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 40,
    this.child,
    this.colors,
    this.gradient,
  });

  @override
  State<MorphingContainer> createState() => _MorphingContainerState();
}

class _MorphingContainerState extends State<MorphingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Decoration _buildDecoration() {
    // ✅ Priority: gradient > colors > fallback

    if (widget.gradient != null) {
      return BoxDecoration(
        gradient: widget.gradient,
      );
    }

    final colors = widget.colors;

    if (colors != null && colors.isNotEmpty) {
      if (colors.length == 1) {
        return BoxDecoration(
          color: colors.first,
        );
      } else {
        return BoxDecoration(
          gradient: LinearGradient(colors: colors),
        );
      }
    }

    return BoxDecoration(
      color: Colors.grey.shade800,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return ClipPath(
          clipper: ShapeClipper(
            t: controller.value,
            baseRadius: widget.borderRadius,
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: _buildDecoration(),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  final double t;
  final double baseRadius;

  ShapeClipper({required this.t, required this.baseRadius});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    double r1 = _radius(t, 0.0);
    double r2 = _radius(t, 0.25);
    double r3 = _radius(t, 0.5);
    double r4 = _radius(t, 0.75);

    final path = Path();

    path.moveTo(w * 0.5, 0);

    path.quadraticBezierTo(w, 0, w, h * r2);
    path.quadraticBezierTo(w, h, w * (1 - r3), h);
    path.quadraticBezierTo(0, h, 0, h * (1 - r4));
    path.quadraticBezierTo(0, 0, w * r1, 0);

    path.close();

    return path;
  }

  double _radius(double t, double shift) {
    double wave = sin((t + shift) * 2 * pi) * 0.3 + 0.5;
    return (wave * baseRadius) / 100;
  }

  @override
  bool shouldReclip(covariant ShapeClipper oldClipper) {
    return oldClipper.t != t;
  }
}
