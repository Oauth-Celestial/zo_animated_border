import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoGlowEdgeBorder extends StatelessWidget {
  const ExZoGlowEdgeBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Glow Edge Border",
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
            ZoGlowingEdgeBorder(
              gradientColors: [
                Colors.orange,
                Colors.white,
                Colors.green,
              ],
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Glow Edge Border",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ZoGlowingEdgeBorder(
              gradientColors: [
                Colors.orange,
                Colors.white,
                Colors.green,
                Colors.indigo,
                Colors.pink
              ],
              borderRadius: 100,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: Text(
                    "Glow Edge Border",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
