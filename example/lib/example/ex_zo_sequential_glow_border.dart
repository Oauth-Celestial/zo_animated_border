import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoSequentialGlowBorder extends StatelessWidget {
  const ExZoSequentialGlowBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C12),
      body: Center(
        child: ZoSequentialGlowBorder(
          borderRadius: BorderRadius.circular(10),
          borderWidth: 4.0,
          glowRadius: 10.0,
          duration: const Duration(seconds: 4),
          gradientPalettes: const [
            [Color(0xFF6B2AFF), Color(0xFF00E5FF)], // Purple to Cyan
            [Color(0xFFFF2A85), Color(0xFFFF992A)], // Pink to Orange
            [Color(0xFF00FF87), Color(0xFF60EFFF)], // Green to Blue
          ],
          child: Container(
            width: 250,
            height: 250,
            alignment: Alignment.center,
            child: const Text(
              "Sequential Glow Border",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
