import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_dotted_border.dart';

class ExZoDottedBorder extends StatelessWidget {
  const ExZoDottedBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              borderStyle: BorderStyleType.monochrome,
            )
          ],
        ),
      ],
    );
  }
}
