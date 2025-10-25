import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
          child: ZoSnakeBorder(
            width: 250,
            height: 250,
            borderWidth: 4,
            colorFrom: Colors.cyanAccent,
            colorTo: Colors.blue,
            staticBorderColor: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            glowOpacity: 0.6,
            child: Icon(Icons.flutter_dash, size: 50, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ZoSnakeBorder extends StatefulWidget {
  final double width;
  final double height;
  final double borderWidth;
  final Color colorFrom;
  final Color colorTo;
  final Color staticBorderColor;
  final BorderRadius borderRadius;
  final double glowOpacity;
  final Widget child;

  const ZoSnakeBorder({
    super.key,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.colorFrom,
    required this.colorTo,
    required this.staticBorderColor,
    required this.borderRadius,
    this.glowOpacity = 0.8,
    required this.child,
  });

  @override
  State<ZoSnakeBorder> createState() => _ZoSnakeBorderState();
}

class _ZoSnakeBorderState extends State<ZoSnakeBorder>
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

  Offset _getPositionAlongPath(Size size, double progress) {
    final rect = Offset.zero & size;
    final rrect = widget.borderRadius.toRRect(rect);
    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final totalLength = metric.length;
    final pos = metric.getTangentForOffset(progress * totalLength)?.position ??
        Offset.zero;
    return pos;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value;
        return CustomPaint(
          painter: ZoSnakeBorderPainter(
            progress: _controller,
            borderWidth: widget.borderWidth,
            colorFrom: widget.colorFrom,
            colorTo: widget.colorTo,
            staticBorderColor: widget.staticBorderColor,
            borderRadius: widget.borderRadius,
            glowOpacity: widget.glowOpacity,
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(child: widget.child),
                // Moving child along path
                Positioned(
                  left: _getPositionAlongPath(
                              Size(widget.width, widget.height), progress)
                          .dx -
                      10,
                  top: _getPositionAlongPath(
                              Size(widget.width, widget.height), progress)
                          .dy -
                      10,
                  child: const _FollowerDot(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FollowerDot extends StatelessWidget {
  const _FollowerDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.cyanAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent,
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class ZoSnakeBorderPainter extends CustomPainter {
  final Animation<double> progress;
  final double borderWidth;
  final Color colorFrom;
  final Color colorTo;
  final Color staticBorderColor;
  final BorderRadius borderRadius;
  final double glowOpacity;

  ZoSnakeBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.colorFrom,
    required this.colorTo,
    required this.staticBorderColor,
    required this.borderRadius,
    this.glowOpacity = 0.8,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    // Static border
    final staticPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = staticBorderColor;
    canvas.drawRRect(rrect, staticPaint);

    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;
    final totalLength = metric.length;

    final start = (progress.value % 1.0) * totalLength;
    final segmentLength = totalLength / 4;
    final end = (start + segmentLength) % totalLength;

    Path extractPath;
    if (end > start) {
      extractPath = metric.extractPath(start, end);
    } else {
      extractPath = Path()
        ..addPath(metric.extractPath(start, totalLength), Offset.zero)
        ..addPath(metric.extractPath(0, end), Offset.zero);
    }

    final p1 = metric.getTangentForOffset(start)?.position ?? Offset.zero;
    final p2 = metric.getTangentForOffset(end)?.position ?? Offset.zero;

    final gradient = ui.Gradient.linear(
      p1,
      p2,
      [
        colorFrom.withValues(alpha: 0.8),
        colorTo,
        colorFrom.withValues(alpha: 0.8),
      ],
      [0.0, 0.5, 1.0],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient;

    // Glow
    if (glowOpacity > 0) {
      final layers = (glowOpacity * 6).clamp(1, 10).toInt();
      for (int i = 1; i <= layers; i++) {
        final glowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, 5.0 * i * glowOpacity)
          ..shader = ui.Gradient.linear(
            p1,
            p2,
            [
              colorTo.withValues(alpha: 0.7),
              colorFrom.withValues(alpha: 0.4),
            ],
            [0.2, 1.0],
          );
        canvas.drawPath(extractPath, glowPaint);
      }
    }

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant ZoSnakeBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
