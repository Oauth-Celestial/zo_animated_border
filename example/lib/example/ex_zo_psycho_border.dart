import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoPsychoBorder extends StatelessWidget {
  const ExZoPsychoBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Neon Border Example'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: ZoPsychoBorder(
          ringCount: 4,
          maxSpread: 10.0,
          borderRadius: BorderRadius.circular(75),
          colors: const [
            Color(0xFFFF2A85),
            Color(0xFFFF992A),
            Color(0xFF00E5FF),
            Color(0xFF6B2AFF),
          ],
          duration: const Duration(seconds: 3),
          child: Container(
            width: 150,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Z',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
