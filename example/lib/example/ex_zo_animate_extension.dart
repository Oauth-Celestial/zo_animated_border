import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoAnimateExtension extends StatelessWidget {
  const ExZoAnimateExtension({super.key});

  Widget _buildCard({
    required String title,
    required String methodCall,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF334155),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  methodCall,
                  style: const TextStyle(
                    color: Color(0xFF38BDF8),
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(child: child),
        ],
      ),
    );
  }

  Widget _contentBox({
    required String text,
    double radius = 16.0,
    double width = 220,
    double height = 70,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      appBar: AppBar(
        title: const Text('All Borders in Fluent .zoAnimate()'),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          const Text(
            "Auto-Detects BorderRadius & Shape",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // 1. Snake Border
          _buildCard(
            title: "1. Snake Border",
            methodCall: ".zoAnimate().snake()",
            child: _contentBox(text: "Snake Animation", radius: 14)
                .zoAnimate()
                .snake(
                  snakeHeadColor: Colors.cyanAccent,
                  snakeTailColor: Colors.purpleAccent,
                  glowOpacity: 0.8,
                  glowSpread: 6.0,
                  borderWidth: 3,
                ),
          ),

          // 2. Dual Border
          _buildCard(
            title: "2. Dual Border",
            methodCall: ".zoAnimate().dual()",
            child: _contentBox(text: "Dual Running Glow", radius: 14)
                .zoAnimate()
                .dual(
                  firstBorderColor: Colors.amberAccent,
                  secondBorderColor: Colors.deepOrangeAccent,
                  glowOpacity: 0.6,
                  borderWidth: 3,
                ),
          ),

          // 3. Glowing Edge Border
          _buildCard(
            title: "3. Glowing Edge Border",
            methodCall: ".zoAnimate().glowEdge()",
            child: _contentBox(text: "Glowing Edge", radius: 16)
                .zoAnimate()
                .glowEdge(
                  gradientColors: [Colors.pinkAccent, Colors.cyanAccent],
                  borderWidth: 4,
                  edgeLength: 90,
                ),
          ),

          // 4. Gradient Border
          _buildCard(
            title: "4. Rotating Gradient",
            methodCall: ".zoAnimate().gradient()",
            child: _contentBox(text: "Gradient Sweep", radius: 20)
                .zoAnimate()
                .gradient(
                  gradientColor: [
                    Colors.purpleAccent,
                    Colors.cyanAccent,
                    Colors.amberAccent
                  ],
                  glowOpacity: 0.7,
                  glowSpread: 6,
                  borderThickness: 3,
                ),
          ),

          // 5. Pulsating Border
          _buildCard(
            title: "5. Pulsating Border",
            methodCall: ".zoAnimate().pulsating()",
            child: _contentBox(text: "Pulsing Aura", radius: 14)
                .zoAnimate()
                .pulsating(
                  pulseColor: const Color(0xFF6366F1),
                  layerCount: 3,
                ),
          ),

          // 6. Breathing Border
          _buildCard(
            title: "6. Breathing Border",
            methodCall: ".zoAnimate().breathing()",
            child: _contentBox(text: "Color Breathing", radius: 14)
                .zoAnimate()
                .breathing(
                  colors: [Colors.tealAccent, Colors.pinkAccent, Colors.orangeAccent],
                  borderWidth: 3,
                ),
          ),

          // 7. Dotted Border
          _buildCard(
            title: "7. Animated Dotted Border",
            methodCall: ".zoAnimate().dotted()",
            child: _contentBox(text: "Dotted Running Path", radius: 12)
                .zoAnimate()
                .dotted(
                  color: Colors.lightGreenAccent,
                  strokeWidth: 3,
                  dashLength: 8,
                  gapLength: 6,
                ),
          ),

          // 8. MultiColor Border
          _buildCard(
            title: "8. Multi-Color Border",
            methodCall: ".zoAnimate().multiColor()",
            child: _contentBox(text: "Multi-Segment", radius: 14)
                .zoAnimate()
                .multiColor(
                  colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue],
                  strokeWidth: 4,
                  gapLength: 4,
                ),
          ),

          // 9. Color Changing Border
          _buildCard(
            title: "9. Color Changing Border",
            methodCall: ".zoAnimate().colorChange()",
            child: _contentBox(text: "Chameleon Segment", radius: 16)
                .zoAnimate()
                .colorChange(
                  colors: [Colors.cyan, Colors.purple, Colors.orange],
                  borderWidth: 4,
                  segmentLength: 0.2,
                ),
          ),

          // 10. Segment Border
          _buildCard(
            title: "10. Segment Border",
            methodCall: ".zoAnimate().segment()",
            child: _contentBox(text: "Glowing Segment", radius: 16)
                .zoAnimate()
                .segment(
                  colors: [Colors.cyanAccent, Colors.purpleAccent],
                  segmentLength: 0.2,
                  glowOpacity: 0.9,
                ),
          ),

          // 11. Fire Border
          _buildCard(
            title: "11. Fire Border with Particles",
            methodCall: ".zoAnimate().fire()",
            child: _contentBox(text: "Fire Trail", radius: 14)
                .zoAnimate()
                .fire(
                  borderWidth: 4,
                  snakeLength: 0.15,
                  gradient: const SweepGradient(
                    colors: [Colors.orange, Colors.red, Colors.yellow],
                  ),
                ),
          ),

          // 12. Psycho Border
          _buildCard(
            title: "12. Psycho Border",
            methodCall: ".zoAnimate().psycho()",
            child: _contentBox(text: "Psycho Wave", radius: 14)
                .zoAnimate()
                .psycho(
                  ringCount: 3,
                  maxSpread: 10.0,
                  colors: [
                    Colors.pinkAccent,
                    Colors.orangeAccent,
                    Colors.cyanAccent,
                  ],
                ),
          ),

          // 13. Sequential Glow Border
          _buildCard(
            title: "13. Sequential Glow Border",
            methodCall: ".zoAnimate().sequentialGlow()",
            child: _contentBox(text: "Sequential Wipe", radius: 14)
                .zoAnimate()
                .sequentialGlow(
                  glowRadius: 10.0,
                  borderWidth: 4.0,
                ),
          ),

          // 14. Signal Border
          _buildCard(
            title: "14. Signal Border",
            methodCall: ".zoAnimate().signal()",
            child: _contentBox(text: "Radar Signal", radius: 14)
                .zoAnimate()
                .signal(
                  ringColors: [Colors.blueAccent, Colors.cyanAccent],
                  spaceBetween: 12,
                ),
          ),

          // 15. Ripple Border
          _buildCard(
            title: "15. Ripple Border",
            methodCall: ".zoAnimate().ripple()",
            child: SizedBox(
              width: 140,
              height: 140,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.touch_app, color: Colors.black),
                ).zoAnimate().ripple(
                      numberOfCircles: 3,
                      rippleColor: Colors.amberAccent,
                      minCircleSize: 50,
                    ),
              ),
            ),
          ),

          // 16. Scribble Border
          _buildCard(
            title: "16. Scribble Border",
            methodCall: ".zoAnimate().scribble()",
            child: _contentBox(text: "Hand Drawn Scribble", radius: 16)
                .zoAnimate()
                .scribble(
                  borderColor: Colors.greenAccent,
                  borderWidth: 6,
                  glowOpacity: 0.7,
                ),
          ),

          // 17. Rotating Text Border
          _buildCard(
            title: "17. Rotating Text Border",
            methodCall: ".zoAnimate().textBorder()",
            child: _contentBox(text: "Text Following Border", radius: 16, width: 260, height: 90)
                .zoAnimate()
                .textBorder(
                  text: "ZO ANIMATED BORDER • FLUTTER • ",
                  textStyle: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
          ),

          // 18. Monochrome Border
          _buildCard(
            title: "18. Monochrome Border",
            methodCall: ".zoAnimate().monochrome()",
            child: _contentBox(text: "Monochrome Sweep", radius: 14)
                .zoAnimate()
                .monochrome(
                  trackBorderColor: Colors.redAccent,
                  borderWidth: 3,
                ),
          ),

          // 19. Chained Multi-Border
          _buildCard(
            title: "19. Chained Multi-Border Demo",
            methodCall: ".snake().pulsating()",
            child: _contentBox(text: "Snake + Pulsating", radius: 16)
                .zoAnimate()
                .snake(
                  snakeHeadColor: Colors.greenAccent,
                  snakeTailColor: Colors.cyanAccent,
                  borderWidth: 3,
                )
                .pulsating(
                  pulseColor: Colors.greenAccent.withValues(alpha: 0.3),
                  layerCount: 2,
                ),
          ),
        ],
      ),
    );
  }
}
