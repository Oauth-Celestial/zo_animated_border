import 'dart:math' as math;
import 'package:example/example/ex_text_border.dart';
import 'package:example/example/ex_zo_dual_border.dart';
import 'package:example/example/ex_zo_scribble_border.dart';
import 'package:flutter/material.dart';
import 'package:characters/characters.dart';
import 'package:zo_animated_border/painter/zo_rotating_text_border_painter.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ExZoDualBorder(),
    );
  }
}


// https://www.sliderrevolution.com/resources/css-border-animation/