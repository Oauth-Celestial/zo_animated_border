import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoRippleBorder extends StatefulWidget {
  const ExZoRippleBorder({super.key});

  @override
  State<ExZoRippleBorder> createState() => _ExZoRippleBorderState();
}

class _ExZoRippleBorderState extends State<ExZoRippleBorder> {
  @override
  Widget build(BuildContext context) {
    return ZoRippleBorder(
      rippleColor: Colors.cyanAccent,
      minCircleSize: 120,
      numberOfCircles: 4,
      animationDuration: Duration(seconds: 4),
      child: const CircleAvatar(
        radius: 40,
        backgroundColor: Colors.cyanAccent,
        child: Icon(Icons.home, color: Colors.white, size: 30),
      ),
    );
  }
}
