import 'package:flutter/material.dart';

import 'package:zo_animated_border/widget/zo_text_border.dart';

class ExZoTextBorder extends StatelessWidget {
  const ExZoTextBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
          ),
          ZoTextBorder(
            text: "Zo Text Border",
            borderRadius: BorderRadius.circular(30),
            padding: 15,
            textStyle: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 2, // Added spacing for better legibility
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {},
              child:
                  const Text("EXPLORE", style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // Example: A Square with Sharp Corners
          ZoTextBorder(
            text: "SYSTEM  ",
            borderRadius: BorderRadius.circular(100),
            padding: 12,
            duration: const Duration(seconds: 12),
            textStyle: const TextStyle(color: Colors.greenAccent, fontSize: 12),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.shield, color: Colors.greenAccent, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
