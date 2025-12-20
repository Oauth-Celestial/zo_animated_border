import 'dart:math';
import 'package:example/example/ex_zo_hand_border.dart';
import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_hand_drawn_border.dart';

void main() => runApp(
    const MaterialApp(home: DemoPage(), debugShowCheckedModeBanner: false));

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background from image
      body: Center(child: ExZoHandDrawBorder()),
    );
  }
}
