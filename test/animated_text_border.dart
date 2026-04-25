import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PathTextDemo()));

class PathTextDemo extends StatelessWidget {
  const PathTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Example: A Rounded Button with Readable Rotating Text
            TextPathWrapper(
              text: "Zo Text Border ",
              borderRadius: BorderRadius.circular(30),
              padding: 15,
              textStyle: const TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2, // Added spacing for better legibility
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  fixedSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {},
                child: const Text("EXPLORE",
                    style: TextStyle(color: Colors.black)),
              ),
            ),

            // Example: A Square with Sharp Corners
            TextPathWrapper(
              text: "SYSTEM RUNNING ",
              borderRadius: BorderRadius.circular(100),
              padding: 12,
              duration: const Duration(seconds: 12),
              textStyle:
                  const TextStyle(color: Colors.greenAccent, fontSize: 12),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shield,
                    color: Colors.greenAccent, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextPathWrapper extends StatefulWidget {
  final Widget child;
  final String text;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final double padding;
  final Duration duration;

  const TextPathWrapper({
    super.key,
    required this.child,
    required this.text,
    this.borderRadius = BorderRadius.zero,
    this.padding = 10.0,
    this.duration = const Duration(seconds: 10),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 12),
  });

  @override
  State<TextPathWrapper> createState() => _TextPathWrapperState();
}

class _TextPathWrapperState extends State<TextPathWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: PathTextPainter(
                  text: widget.text,
                  textStyle: widget.textStyle,
                  borderRadius: widget.borderRadius,
                  padding: widget.padding,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PathTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final double padding;
  final double progress;

  PathTextPainter({
    required this.text,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Define the Path (RRect based on child size + padding)
    final Rect rect = Offset(-padding, -padding) &
        Size(size.width + padding * 2, size.height + padding * 2);
    final RRect rrect = borderRadius.toRRect(rect);
    final Path path = Path()..addRRect(rrect);

    final PathMetric metric = path.computeMetrics().first;
    final double pathLength = metric.length;

    // 2. Measure individual characters
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    List<double> charWidths = [];
    double totalTextWidth = 0;

    for (int i = 0; i < text.length; i++) {
      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();
      // Add extra space between characters for readability
      double widthWithSpacing =
          textPainter.width + (textStyle.letterSpacing ?? 0);
      charWidths.add(widthWithSpacing);
      totalTextWidth += widthWithSpacing;
    }

    // 3. Spacing logic
    double gapBetweenRepeats = 40.0;
    int repeats = (pathLength / (totalTextWidth + gapBetweenRepeats)).floor();
    repeats = math.max(1, repeats);
    double segmentLength = pathLength / repeats;

    // 4. Draw Characters
    for (int r = 0; r < repeats; r++) {
      // Offset starting position by progress and repeat index
      double currentDist = (progress * pathLength) + (r * segmentLength);

      for (int i = 0; i < text.length; i++) {
        double actualDist = currentDist % pathLength;
        Tangent? tangent = metric.getTangentForOffset(actualDist);

        if (tangent != null) {
          textPainter.text = TextSpan(text: text[i], style: textStyle);
          textPainter.layout();

          canvas.save();
          // Move to point on path
          canvas.translate(tangent.position.dx, tangent.position.dy);

          // --- READABILITY TWEAK ---
          // Rotate based on path angle. Subtracting tangent angle makes it follow the path.
          // No added pi/2 means the text sits 'upright' on the line.
          canvas.rotate(-tangent.angle);

          // Center character on the path line
          canvas.translate(0, -textPainter.height / 2);
          textPainter.paint(canvas, Offset(-textPainter.width / 2, 0));
          canvas.restore();
        }
        currentDist += charWidths[i];
      }
    }
  }

  @override
  bool shouldRepaint(PathTextPainter oldDelegate) => true;
}
