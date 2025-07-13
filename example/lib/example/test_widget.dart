import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = [
      ZoAnimatedGradientBorder(
        borderRadius: 100,
        borderThickness: 4,
        gradientColor: [Colors.yellow, Colors.orange],
        duration: const Duration(seconds: 4),
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(shape: BoxShape.circle),
        ),
      ),
      ZoAnimatedGradientBorder(
        borderRadius: 30,
        borderThickness: 2,
        shouldAnimate: false,
        gradientColor: [Colors.red, Colors.blue],
        duration: const Duration(seconds: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 150,
            height: 45,
            alignment: Alignment.center,
            color: Colors.black,
            child:
                const Text("Click Me", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      ZoAnimatedGradientBorder(
        borderThickness: 3,
        shouldAnimate: false,
        borderRadius: 30,
        gradientColor: [Colors.orange, Colors.white, Colors.green],
        duration: const Duration(seconds: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 150,
            height: 45,
            alignment: Alignment.center,
            color: Colors.white,
            child:
                const Text("Click Me", style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
      ZoMultiColorBorder(
        colors: [
          Colors.orange,
          Colors.white,
          Colors.green,
          Colors.indigo,
          Colors.pink
        ],
        strokeWidth: 3,
        borderRadius: 75,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      ZoMultiColorBorder(
        colors: [Colors.orange, Colors.white, Colors.green],
        strokeWidth: 3,
        borderRadius: 0,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(width: 80, height: 80),
        ),
      ),
      ZoMultiColorBorder(
        colors: [Colors.orange, Colors.purple, Colors.green],
        strokeWidth: 5,
        borderRadius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 150,
            height: 45,
            alignment: Alignment.center,
            color: Colors.white,
            child: const Text("Click Me",
                style: TextStyle(color: Colors.black, fontSize: 10)),
          ),
        ),
      ),
      ZoDualBorder(
        duration: const Duration(seconds: 3),
        glowOpacity: 0.4,
        firstBorderColor: Colors.yellow,
        secondBorderColor: Colors.orange,
        trackBorderColor: Colors.transparent,
        borderWidth: 8,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
      ZoDottedBorder(
        child: Container(height: 80, width: 80),
        animate: true,
        borderRadius: 60,
        dashLength: 10,
        gapLength: 5,
        strokeWidth: 3,
        color: Colors.blue,
        animationDuration: const Duration(seconds: 4),
        borderStyle: BorderStyleType.monochrome,
      ),
      ZoPulsatingBorder(
        type: ZoPulsatingBorderType.pulse,
        borderRadius: BorderRadius.circular(100),
        pulseColor: Colors.blue,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      ZoSnakeBorder(
        duration: 3,
        glowOpacity: 0,
        snakeHeadColor: Colors.red,
        snakeTailColor: Colors.blue,
        snakeTrackColor: Colors.blueGrey,
        borderWidth: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 150,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      ZoMonoCromeBorder(
        trackBorderColor: Colors.yellow,
        cornerRadius: 50.0,
        borderStyle: ZoMonoCromeBorderStyle.mirror,
        borderWidth: 5.5,
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
      ZoColorChangingBorder(
        colors: [
          Colors.orange,
          Colors.white,
          Colors.green,
          Colors.indigo,
          Colors.pink
        ],
        segmentLength: 0.2,
        borderRadius: 75,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.transparent, shape: BoxShape.circle),
          ),
        ),
      ),
      ZoGlowingEdgeBorder(
        gradientColors: [
          Colors.orange,
          Colors.white,
          Colors.green,
        ],
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ZoGlowingEdgeBorder(
              duration: Duration(seconds: 8),
              gradientColors: [
                Colors.orange,
                Colors.white,
                Colors.green,
              ],
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  "ZoAnimatedBorder",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 5,
                childAspectRatio: 1.1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: widgets.map((w) {
                  return Center(child: w);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
