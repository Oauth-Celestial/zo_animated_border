import 'package:flutter/material.dart';
import 'dart:math';

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
        child: ZoSnakeBorder(
          duration: const Duration(seconds: 3),
          borderWidth: 4,
          snakeLength: 0.8, // 20% of the total border length
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.red, Colors.yellow],
          ),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.local_fire_department,
                color: Colors.white, size: 60),
          ),
        ),
      ),
    );
  }
}

class ZoSnakeBorder extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double borderWidth;
  final double snakeLength; // New parameter: 0.0 to 1.0
  final BorderRadius borderRadius;
  final Gradient gradient;

  const ZoSnakeBorder({
    super.key,
    required this.child,
    required this.duration,
    required this.borderWidth,
    this.snakeLength = 0.1, // Default to 10%
    required this.borderRadius,
    required this.gradient,
  });

  @override
  State<ZoSnakeBorder> createState() => _ZoSnakeBorderState();
}

class _ZoSnakeBorderState extends State<ZoSnakeBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final List<Particle> particles = [];
  final Random random = Random();
  Offset _currentHeadPos = Offset.zero;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(_updateParticles)
      ..repeat();
  }

  void _updateParticles() {
    for (final p in particles) {
      p.update();
    }
    particles.removeWhere((p) => p.life <= 0);

    // Spawn "trail" particles at the current recorded head position
    for (int i = 0; i < 2; i++) {
      particles.add(Particle.atPosition(_currentHeadPos, random));
    }
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoSnakeBorderPainter(
        progress: controller.value,
        borderWidth: widget.borderWidth,
        snakeLength: widget.snakeLength,
        gradient: widget.gradient,
        borderRadius: widget.borderRadius,
        particles: particles,
        onPositionUpdate: (pos) => _currentHeadPos = pos,
      ),
      child: widget.child,
    );
  }
}

class ZoSnakeBorderPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final double snakeLength;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final List<Particle> particles;
  final Function(Offset) onPositionUpdate;

  ZoSnakeBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.snakeLength,
    required this.gradient,
    required this.borderRadius,
    required this.particles,
    required this.onPositionUpdate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);
    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final length = metric.length;

    // Calculate snake head and tail
    final double headOffset = progress * length;
    final double tailOffset = headOffset - (length * snakeLength);

    final tangent = metric.getTangentForOffset(headOffset % length)!;
    final headPos = tangent.position;

    // Report position back to state to spawn particles correctly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPositionUpdate(headPos);
    });

    // Extract snake segment (handles wrap-around)
    Path segment = Path();
    if (tailOffset < 0) {
      segment.addPath(
          metric.extractPath(tailOffset + length, length), Offset.zero);
      segment.addPath(metric.extractPath(0, headOffset), Offset.zero);
    } else {
      segment.addPath(metric.extractPath(tailOffset, headOffset), Offset.zero);
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(
          Rect.fromCircle(center: headPos, radius: length * snakeLength));

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth * 2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..shader = paint.shader;

    canvas.drawPath(segment, glow);
    canvas.drawPath(segment, paint);

    // Draw trail particles
    for (final p in particles) {
      final particlePaint = Paint()
        ..color = Colors.orangeAccent.withValues(alpha: p.life)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * p.life);

      canvas.drawCircle(p.position, 2.0 * p.life, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  Offset position;
  Offset velocity;
  double life;

  Particle({
    required this.position,
    required this.velocity,
    required this.life,
  });

  // Changed to accept a specific position (the head's position)
  factory Particle.atPosition(Offset pos, Random random) {
    return Particle(
      position: pos,
      // Slight drift so the trail isn't a perfectly static line
      velocity:
          Offset(random.nextDouble() - 0.5, random.nextDouble() - 0.5) * 0.5,
      life: 1.0,
    );
  }

  void update() {
    position += velocity;
    life -= 0.02; // Adjust for trail duration
  }
}
