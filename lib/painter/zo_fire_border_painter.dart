import 'dart:math';

import 'package:flutter/material.dart';

class ZoFireBorderPainter extends CustomPainter {
  final double progress;
  final double borderWidth;
  final double snakeLength;
  final Gradient gradient;
  final Color fireColor;
  final BorderRadius borderRadius;
  final List<Particle> particles;
  final Function(Offset) onPositionUpdate;

  ZoFireBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.snakeLength,
    required this.gradient,
    required this.fireColor,
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
      final particlePaint = Paint()
        ..color = fireColor.withValues(alpha: p.life)
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

  factory Particle.atPosition(Offset pos, Random random) {
    return Particle(
      position: pos,
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
