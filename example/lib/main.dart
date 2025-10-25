import 'package:example/example/ex_zo_dual_border.dart';
import 'package:example/example/ex_zo_multicolor_border.dart';
import 'package:example/example/ex_zo_pulsating_border.dart';
import 'package:example/example/ex_zo_ripple.dart';
import 'package:example/example/ex_zo_snake_border.dart';
import 'package:example/example/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_signal_border.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              // ExZoPulsatingBorder(),
              ExZoSnakeBorder()
            ],
          )),
      // const AnimatedGradientBorderScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: ZoSignalBorder(
            maxRadius: 120,
            ringColors: [
              Colors.yellow,
              Colors.orange,
              Colors.red,
              Colors.purple,
              Colors.blue,
            ],
            child: Container(
              alignment: Alignment.center,
              width: 130,
              height: 130,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Text("Signal Border"),
            ),
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
