import 'package:flutter/material.dart';
import 'package:zo_animated_border/widget/zo_breathing_border.dart';

class ExZoBreathingBorder extends StatelessWidget {
  const ExZoBreathingBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Breathing Border",
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
            ZoBreathingBorder(
              borderWidth: 3.0,
              borderRadius: BorderRadius.circular(100),
              colors: [
                Colors.blue,
                Colors.purple,
                Colors.red,
                Colors.orange,
              ],
              duration: const Duration(seconds: 4),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(75),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Breathing Border',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
