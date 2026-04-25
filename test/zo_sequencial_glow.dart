import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFF1E004B), // Dark background matching the video
      body: Center(
        child: DynamicWipeButton(
          // 1. Pass as many gradient palettes as you want!
          gradientPalettes: [
            [Color(0xFF6B2AFF), Color(0xFF00E5FF)], // Purple to Cyan
            [Color(0xFFFF2A85), Color(0xFFFF992A)], // Pink to Orange
            [Color(0xFF00FF87), Color(0xFF60EFFF)], // Green to Blue (Bonus!)
          ],
          // 2. Control the glow intensity (Set to 0 to disable)
          glowRadius: 10.0,
          strokeWidth: 4.0,
        ),
      ),
    ),
  ));
}

class DynamicWipeButton extends StatefulWidget {
  final List<List<Color>> gradientPalettes;
  final double glowRadius;
  final double strokeWidth;
  final Duration duration;

  const DynamicWipeButton({
    super.key,
    required this.gradientPalettes,
    this.glowRadius = 8.0,
    this.strokeWidth = 4.0,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<DynamicWipeButton> createState() => _DynamicWipeButtonState();
}

class _DynamicWipeButtonState extends State<DynamicWipeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint("Button Clicked!"),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: SequentialWipeGlowPainter(
              progress: _controller.value,
              gradientPalettes: widget.gradientPalettes,
              glowRadius: widget.glowRadius,
              strokeWidth: widget.strokeWidth,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF3800D6), // Deep solid purple body
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Get Started Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Transforms the gradient to physically slide it left-to-right
class SlideWipeGradientTransform extends GradientTransform {
  final double progress;
  final int segmentCount;

  const SlideWipeGradientTransform(this.progress, this.segmentCount);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // We scale the texture to exactly fit all of our gradients.
    // Then we translate it precisely so it slides one full loop cleanly.
    final double shiftX = bounds.width * segmentCount * progress;

    return Matrix4.identity()
      ..translateByDouble(shiftX, 0.0, 0.0, 1.0)
      ..scaleByDouble(segmentCount.toDouble(), 1.0, 1.0, 1.0);
  }
}

class SequentialWipeGlowPainter extends CustomPainter {
  final double progress;
  final List<List<Color>> gradientPalettes;
  final double glowRadius;
  final double strokeWidth;

  SequentialWipeGlowPainter({
    required this.progress,
    required this.gradientPalettes,
    required this.glowRadius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (gradientPalettes.isEmpty) return;

    // 1. Set up the pill shape for the border
    final rect = Offset.zero & size;
    final inflatedRect = rect.inflate(strokeWidth / 2);
    final rrect = RRect.fromRectAndRadius(
      inflatedRect,
      Radius.circular(size.height / 2),
    );

    // 2. Dynamically calculate colors and stops to stitch all palettes side-by-side
    List<Color> combinedColors = [];
    List<double> combinedStops = [];
    int n = gradientPalettes.length;

    for (int i = 0; i < n; i++) {
      List<Color> gColors = gradientPalettes[i];
      // Ensure we have at least 2 colors to make a gradient
      if (gColors.length == 1) gColors = [gColors[0], gColors[0]];
      int m = gColors.length;

      for (int j = 0; j < m; j++) {
        combinedColors.add(gColors[j]);

        // Base mathematical calculation for where this color goes
        double stop = (i / n) + (j / (m - 1)) * (1 / n);

        // Create the "Hard Cut" boundary between different palettes
        if (j == 0 && i > 0) {
          stop = (i / n) + 0.001;
        } else if (j == m - 1 && i < n - 1) {
          stop = ((i + 1) / n) - 0.001;
        }

        combinedStops.add(stop);
      }
    }

    // 3. Create the massive stitched gradient texture
    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: combinedColors,
      stops: combinedStops,
      tileMode: TileMode.repeated, // Loops infinitely
      transform: SlideWipeGradientTransform(progress, n),
    );

    final shader = gradient.createShader(rect);

    // 4. If a glow is requested, paint the blurred version first (Behind)
    if (glowRadius > 0) {
      final glowPaint = Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..maskFilter =
            MaskFilter.blur(BlurStyle.normal, glowRadius); // The Glow

      canvas.drawRRect(rrect, glowPaint);
    }

    // 5. Paint the sharp, solid line (On Top)
    final sharpPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(rrect, sharpPaint);
  }

  @override
  bool shouldRepaint(covariant SequentialWipeGlowPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradientPalettes != gradientPalettes ||
        oldDelegate.glowRadius != glowRadius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
