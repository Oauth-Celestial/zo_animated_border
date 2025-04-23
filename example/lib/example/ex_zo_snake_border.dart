import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoSnakeBorder extends StatelessWidget {
  const ExZoSnakeBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Snake Border",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
