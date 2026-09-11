import 'package:example/example/ex_text_border.dart';
import 'package:example/example/ex_zo_breathing_border.dart';
import 'package:example/example/ex_zo_color_changing_border.dart';
import 'package:example/example/ex_zo_dotted_border.dart';
import 'package:example/example/ex_zo_dual_border.dart';
import 'package:example/example/ex_zo_fire_border.dart';
import 'package:example/example/ex_zo_glowing_edge_border.dart';
import 'package:example/example/ex_zo_gradient_border.dart';
import 'package:example/example/ex_zo_multicolor_border.dart';
import 'package:example/example/ex_zo_psycho_border.dart';
import 'package:example/example/ex_zo_ripple_border.dart';
import 'package:example/example/ex_zo_scribble_border.dart';
import 'package:example/example/ex_zo_segment_border.dart';
import 'package:example/example/ex_zo_sequential_glow_border.dart';
import 'package:example/example/ex_zo_signal_border.dart';
import 'package:example/example/ex_zo_snake_border.dart';

import 'package:flutter/material.dart';

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
      home: const ExZoSegmentBorder(),
    );
  }
}


// https://www.sliderrevolution.com/resources/css-border-animation/