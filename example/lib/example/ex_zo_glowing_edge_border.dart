import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoGlowingEdgeBorder extends StatelessWidget {
  const ExZoGlowingEdgeBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Glow Edge Border",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              ZoGlowingEdgeBorder(
                gradientColors: const [
                  Colors.orange,
                  Colors.white,
                  Colors.green,
                ],
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "Glow Edge Border",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ZoGlowingEdgeBorder(
                gradientColors: const [
                  Colors.orange,
                  Colors.white,
                  Colors.green,
                  Colors.indigo,
                  Colors.pink,
                ],
                borderRadius: 100,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "Glow Edge Border",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
