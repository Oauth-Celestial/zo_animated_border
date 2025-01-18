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
      home: MyHomePage(title: 'Zo Animated Borders'),
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
                  child: Text("Snake Border",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  ZoSnakeBorder(
                    duration: 3,
                    glowOpacity: 0,
                    snakeHeadColor: Colors.red,
                    snakeTailColor: Colors.blue,
                    snakeTrackColor: Colors.blueGrey,
                    borderWidth: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Snake Border",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  ZoSnakeBorder(
                    duration: 3,
                    glowOpacity: 0.3,
                    snakeHeadColor: Colors.red,
                    snakeTailColor: Colors.blue,
                    snakeTrackColor: Colors.blueGrey,
                    borderWidth: 7,
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60)),
                      child: Text(
                        "Snake Border",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ]))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// For animation we need ticker mixin
