import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoColorChangingBorder extends StatelessWidget {
  const ExZoColorChangingBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Color Changing border",
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
            ZoColorChangingBorder(
              borderRadius: 0,
              segmentLength: 0.2,
              colors: [
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
                    "Color Changing Border",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ZoColorChangingBorder(
              colors: [
                Colors.orange,
                Colors.white,
                Colors.green,
                Colors.indigo,
                Colors.pink
              ],
              segmentLength: 0.2,
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
