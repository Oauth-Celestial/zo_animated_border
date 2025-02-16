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
                  child: Text("Dotted Border",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                ZoDottedBorder(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        "MonoChrome",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    animate: true,
                    borderRadius: 10,
                    dashLength: 10,
                    gapLength: 5,
                    strokeWidth: 3,
                    color: Colors.blue,
                    animationDuration: Duration(seconds: 4),
                    borderStyle: BorderStyleType.monochrome),
                SizedBox(
                  width: 40,
                ),
                ZoDottedBorder(
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Gradient",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    animate: true,
                    borderRadius: 70,
                    dashLength: 10,
                    gapLength: 5,
                    strokeWidth: 3,
                    color: Colors.blue,
                    animationDuration: Duration(seconds: 4),
                    borderStyle: BorderStyleType.gradient),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
