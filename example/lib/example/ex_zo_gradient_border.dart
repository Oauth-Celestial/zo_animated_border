import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoGradientBorder extends StatelessWidget {
  const ExZoGradientBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Gradient Border",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                ZoAnimatedGradientBorder(
                  borderRadius: 50,
                  borderThickness: 10,
                  glowOpacity: 0.8,
                  glowSpread: 10.0,
                  gradientColor: const [
                    Colors.yellow,
                    Colors.orange,
                  ],
                  animationDuration: const Duration(seconds: 4),
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Text(
                      "Circle",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
