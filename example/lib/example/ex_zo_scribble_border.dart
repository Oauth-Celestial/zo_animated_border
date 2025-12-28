import 'package:flutter/material.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoHandDrawBorder extends StatelessWidget {
  const ExZoHandDrawBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoScribbleBorder(
                borderColor: Colors.white,
                padding: EdgeInsets.all(20),
                borderRadius: 100,
                child: ClipOval(
                  child: Image.asset(
                    'assets/pnglogo.png', // Replace with your asset
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.face, size: 80, color: Colors.orange),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
