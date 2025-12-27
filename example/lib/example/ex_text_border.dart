import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_rotating_text_border.dart';

class ExZoRotatingText extends StatelessWidget {
  const ExZoRotatingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ZoCircularTextBorder(
          text: 'The Zerone',
          radius: 60,
          rotationDuration: const Duration(seconds: 12),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          child: Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
