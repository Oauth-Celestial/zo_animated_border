import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class ExZoSignalBorder extends StatelessWidget {
  const ExZoSignalBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Signal Border",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 60),
            ZoSignalBorder(
              spaceBetween: 20,
              animationDuration: const Duration(seconds: 3),
              ringColors: const [
                Colors.yellow,
                Colors.orange,
                Colors.red,
                Colors.purple,
                Colors.blue,
              ],
              child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wifi_tethering,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
