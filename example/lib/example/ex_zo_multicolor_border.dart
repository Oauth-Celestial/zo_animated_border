import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoMultiColorBorder extends StatelessWidget {
  const ExZoMultiColorBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Multi Color Border",
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
            ZoMultiColorBorder(
              colors: [
                Colors.orange,
                Colors.white,
                Colors.green,
              ],
              strokeWidth: 3,
              borderRadius: 0,
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
                    "MultiColor Border",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ZoMultiColorBorder(
              colors: [
                Colors.orange,
                Colors.white,
                Colors.green,
                Colors.indigo,
                Colors.pink
              ],
              strokeWidth: 3,
              borderRadius: 75,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: Text(
                    "MultiColor Border",
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
