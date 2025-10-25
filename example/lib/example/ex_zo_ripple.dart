import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_ripple_effect.dart';

class ExZoRipple extends StatefulWidget {
  const ExZoRipple({super.key});

  @override
  State<ExZoRipple> createState() => _ExZoRippleState();
}

class _ExZoRippleState extends State<ExZoRipple> {
  @override
  Widget build(BuildContext context) {
    return ZoRippleEffect(
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
