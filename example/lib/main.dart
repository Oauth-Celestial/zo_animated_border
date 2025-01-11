import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Animated Border"),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Gradient Borders",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZoAnimatedGradientBorder(
                  width: 100,
                  height: 100,
                  borderRadius: 100,
                  borderThickness: 4,
                  gradientColor: [Colors.yellow, Colors.orange],
                  duration: Duration(seconds: 4),
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Text(
                        "Color",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                ZoAnimatedGradientBorder(
                  width: 100,
                  height: 100,
                  borderRadius: 100,
                  borderThickness: 4,
                  gradientColor: [Colors.red, Colors.blue],
                  duration: Duration(seconds: 4),
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Text(
                        "Color",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                ZoAnimatedGradientBorder(
                  width: 100,
                  height: 100,
                  borderRadius: 100,
                  borderThickness: 4,
                  gradientColor: [Colors.orange, Colors.white, Colors.green],
                  duration: Duration(seconds: 4),
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Text(
                        "Color",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ZoAnimatedGradientBorder(
                    width: 150,
                    height: 45,
                    borderThickness: 2,
                    shouldAnimate: false,
                    gradientColor: [Colors.red, Colors.blue],
                    duration: Duration(seconds: 4),
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.black,
                        child: Text(
                          "Click Me",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  ZoAnimatedGradientBorder(
                    width: 150,
                    height: 45,
                    borderThickness: 3,
                    shouldAnimate: true,
                    gradientColor: [Colors.orange, Colors.white, Colors.green],
                    duration: Duration(seconds: 4),
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(
                          "Click Me",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Styled Monocrome Borders",
                      style: TextStyle(color: Colors.white))),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ZoMonoCromeBorder(
                    trackBorderColor: Colors.white,
                    cornerRadius: 50.0,
                    borderStyle: ZoMonoCromeBorderStyle.mirror,
                    borderWidth: 5.5,
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child:
                          Text("Mirror", style: TextStyle(color: Colors.white)),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ZoMonoCromeBorder(
                    trackBorderColor: Colors.white,
                    cornerRadius: 50.0,
                    borderStyle: ZoMonoCromeBorderStyle.repeated,
                    borderWidth: 5.5,
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text("Repeated",
                          style: TextStyle(color: Colors.white)),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ZoMonoCromeBorder(
                    trackBorderColor: Colors.white,
                    cornerRadius: 50.0,
                    borderStyle: ZoMonoCromeBorderStyle.stroke,
                    borderWidth: 5.5,
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child:
                          Text("Stroke", style: TextStyle(color: Colors.white)),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Pulse Borders",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  ZoPulsatingBorder(
                    layerCount: 2,
                    type: ZoPulsatingBorderType.radarPulse,
                    pulseColor: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Radar Pulse",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),

                  // For circle pulse
                  ZoPulsatingBorder(
                    type: ZoPulsatingBorderType.pulse,
                    borderRadius: BorderRadius.circular(100),
                    pulseColor: Colors.blue,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Radar Pulse",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// For animation we need ticker mixin
