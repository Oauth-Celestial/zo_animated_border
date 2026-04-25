import 'package:example/example/ex_zo_fire_border.dart';

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
      home: const ExZoFireBorder(),
    );
  }
}


// https://www.sliderrevolution.com/resources/css-border-animation/