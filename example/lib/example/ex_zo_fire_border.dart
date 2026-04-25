import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoFireBorder extends StatelessWidget {
  const ExZoFireBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ZoFireBorder(
          duration: const Duration(seconds: 3),
          borderWidth: 4,
          snakeLength: 0.8, // 20% of the total border length
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.red, Colors.yellow],
          ),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.local_fire_department,
                color: Colors.white, size: 60),
          ),
        ),
      ),
    );
  }
}
