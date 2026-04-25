import 'dart:math';

import 'package:flutter/material.dart';

class ZoFireBorderPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final double snakeLength;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final List<Particle> particles;
  final List<Color>? particleColors;
  final Function(Offset) onPositionUpdate;

  ZoFireBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.snakeLength,
    required this.gradient,
    required this.borderRadius,
    required this.particles,
    this.particleColors,
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPositionUpdate(headPos);
    });

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
      if (p.life <= 0) continue;
      final particlePaint = Paint()
        ..color = p.color.withValues(alpha: p.life.clamp(0.0, 1.0))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(p.position, p.size * p.life, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  Offset position;
  Offset velocity;
  double life;
  Color color;
  double size;

  Particle({
    required this.position,
    required this.velocity,
    required this.life,
    required this.color,
    required this.size,
  });

  factory Particle.atPosition(Offset pos, Random random,
      {List<Color>? customColors}) {
    final colors =
        customColors ?? [Colors.red, Colors.orangeAccent, Colors.yellow];
    final double angle = random.nextDouble() * 2 * pi;
    final double speed = random.nextDouble() * 2.0; // Blast speed

    return Particle(
      position: pos,
      velocity: Offset(cos(angle), sin(angle)) * speed,
      life: 1.0,
      color: colors[random.nextInt(colors.length)],
      size: random.nextDouble() * 3.0 + 2.0, // Size between 2.0 and 5.0
    );
  }

  void update() {
    position += velocity;
    life -= 0.03; // Fade duration
  }
}
