import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ZoAnimatedGradientBorder(
                borderRadius: 100,
                borderThickness: 4,
                gradientColor: [
                  Colors.yellow,
                  Colors.orange,
                ],
                duration: Duration(seconds: 4),
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              ZoAnimatedGradientBorder(
                borderThickness: 2,
                borderRadius: 30,
                shouldAnimate: false,
                gradientColor: [Colors.red, Colors.blue],
                duration: Duration(seconds: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Text(
                        "Click Me",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              ZoAnimatedGradientBorder(
                borderThickness: 3,
                shouldAnimate: false,
                borderRadius: 30,
                gradientColor: [Colors.orange, Colors.white, Colors.green],
                duration: Duration(seconds: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        "Click Me",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              children: [
                SizedBox(
                  width: 190,
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
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle),
                    ),
                  ),
                ),
                SizedBox(
                  width: 210,
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
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 210,
                ),
                ZoMultiColorBorder(
                  colors: [
                    Colors.orange,
                    Colors.purple,
                    Colors.green,
                  ],
                  strokeWidth: 5,
                  borderRadius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        width: 150,
                        height: 45,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(
                          "Click Me",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Transform.translate(
            offset: Offset(-20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZoDualBorder(
                  duration: Duration(seconds: 3),
                  glowOpacity: 0.4,
                  firstBorderColor: Colors.yellow,
                  secondBorderColor: Colors.orange,
                  trackBorderColor: Colors.transparent,
                  borderWidth: 8,
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                ZoDottedBorder(
                  child: Container(
                    height: 80,
                    width: 80,
                  ),
                  animate: true,
                  borderRadius: 60,
                  dashLength: 10,
                  gapLength: 5,
                  strokeWidth: 3,
                  color: Colors.blue,
                  animationDuration: Duration(seconds: 4),
                  borderStyle: BorderStyleType.monochrome,
                ),
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
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ZoMonoCromeBorder(
                trackBorderColor: Colors.yellow,
                cornerRadius: 50.0,
                borderStyle: ZoMonoCromeBorderStyle.mirror,
                borderWidth: 5.5,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
