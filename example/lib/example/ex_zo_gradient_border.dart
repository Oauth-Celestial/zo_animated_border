import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoGradientBorder extends StatelessWidget {
  const ExZoGradientBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text("Gradient Border",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              ZoAnimatedGradientBorder(
                borderRadius: 50,
                borderThickness: 5,
                glowOpacity: 0.5,
                gradientColor: [
                  Colors.yellow,
                  Colors.orange,
                ],
                duration: Duration(seconds: 4),
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Text(
                    "Circle",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
