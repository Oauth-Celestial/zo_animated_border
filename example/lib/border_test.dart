import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class BorderBeamHomeWidget extends StatelessWidget {
  const BorderBeamHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ZoSnakeBorder(
          duration: 7,
          borderWidth: 5,
          snakeHeadColor: Colors.blue,

          snakeTailColor: Colors.purple,
          staticBorderColor:
              const Color.fromARGB(255, 39, 39, 42), //rgb(39 39 42)
          borderRadius: BorderRadius.circular(10),

          child: Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: const Center(
              child: Text('Border Beam',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
