import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoDualBorder extends StatelessWidget {
  const ExZoDualBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Dual Border",
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
            ZoDualBorder(
              animationDuration: Duration(seconds: 3),
              glowOpacity: 0.4,
              firstBorderColor: Colors.yellow,
              secondBorderColor: Colors.orange,
              trackBorderColor: Colors.transparent,
              borderWidth: 8,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 150,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Dual Border",
                  style: TextStyle(
                    color: Colors.black,
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
