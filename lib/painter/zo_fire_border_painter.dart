import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/util/zo_path_helper.dart';

/// A custom painter that renders [ZoFireBorderPainter].
class ZoFireBorderPainter extends CustomPainter {
  /// The current progress of the animation from 0.0 to 1.0.
  final Animation<double> progress;
  /// The thickness of the border.
  final double borderWidth;
  /// The relative length of the snake border segment.
  final double snakeLength;
  /// The gradient used to color the border.
  final Gradient gradient;
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  /// The list of active particles in the animation.
  final List<Particle> particles;
  /// The colors of trailing particles.
  final List<Color>? particleColors;
  /// Random instance for particle generation
  final Random random;

  /// Creates a [ZoFireBorderPainter] instance.
  ZoFireBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.snakeLength,
    required this.gradient,
    required this.borderRadius,
    required this.particles,
    this.particleColors,
    required this.random,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final path = ZoPathHelper.createRRectPath(size, borderRadius);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final length = metric.length;
    if (length == 0) return;

    // Calculate snake head and tail
    final double headOffset = progress.value * length;
    final double tailOffset = headOffset - (length * snakeLength);

    final headPos = ZoPathHelper.getTangentPosition(metric, headOffset);

    // Advance particles simulation on paint
    for (final p in particles) {
      p.update();
    }
    particles.removeWhere((p) => p.life <= 0);

    for (int i = 0; i < 3; i++) {
      particles.add(Particle.atPosition(
        headPos,
        random,
        customColors: particleColors,
      ));
    }

    final segment = ZoPathHelper.extractLoopedSubPath(metric, tailOffset, headOffset);

    final shader = gradient.createShader(
        Rect.fromCircle(center: headPos, radius: length * snakeLength));

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth * 1.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 6)
      ..shader = shader;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..shader = shader;

    canvas.drawPath(segment, glow);
    canvas.drawPath(segment, paint);

    // Draw trail particles
    for (final p in particles) {
      if (p.life <= 0) continue;
      final particlePaint = Paint()
        ..color = p.color.withValues(alpha: p.life.clamp(0.0, 1.0))
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

      canvas.drawCircle(p.position, p.size * p.life, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ZoFireBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.snakeLength != snakeLength ||
        oldDelegate.gradient != gradient ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.particleColors != particleColors;
  }
}

/// The [Particle] class.
class Particle {
  /// The [position] property.
  Offset position;
  /// The [velocity] property.
  Offset velocity;
  /// The [life] property.
  double life;
  /// The primary color of the border animation.
  Color color;
  /// The size of the border or particle.
  double size;

  /// Creates a [Particle] instance.
  Particle({
    required this.position,
    required this.velocity,
    required this.life,
    required this.color,
    required this.size,
  });

  /// The [atPosition] property.
  factory Particle.atPosition(Offset pos, Random random,
      {List<Color>? customColors}) {
    final colors = (customColors != null && customColors.isNotEmpty)
        ? customColors
        : [Colors.red, Colors.orangeAccent, Colors.yellow];
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

  /// The [update] property.
  void update() {
    position += velocity;
    life -= 0.04; // Fade duration
  }
}

