import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoSegmentBorder extends StatelessWidget {
  const ExZoSegmentBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C12),
      body: Center(
        child: ZoSegmentBorder(
          borderRadius: 20,
          segmentLength: 0.2,
          glowOpacity: 1.0,
          glowSpread: 5,
          colors: const [
            Colors.cyanAccent,
            Colors.green,
          ],
          child: Container(
            width: 250,
            height: 120,
            alignment: Alignment.center,
            child: const Text(
              "Zo Segment Border",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
