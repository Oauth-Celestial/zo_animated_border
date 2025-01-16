// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

// class AnimatedGradientBorderScreen extends StatefulWidget {
//   const AnimatedGradientBorderScreen({super.key});

//   @override
//   State<AnimatedGradientBorderScreen> createState() =>
//       _AnimatedGradientBorderScreenState();
// }

// class _AnimatedGradientBorderScreenState
//     extends State<AnimatedGradientBorderScreen>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;
//   late final Tween<double> _animTween;
//   late final Animation<double> _turnAnim;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 5));
//     _animTween = Tween<double>(begin: 0.1, end: 2 * math.pi);
//     _turnAnim = _animTween.animate(_animationController);

//     _animationController
//       ..forward()
//       ..repeat(reverse: false);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(title: const Text('Animated Gradient Border')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 0,
//           ),
//           Container(
//               height: 300,
//               width: 300,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(300)),
//               child: AnimatedBuilder(
//                   animation: _turnAnim,
//                   builder: (context, child) {
//                     return CustomPaint(
//                       painter: BorderPainter(angle: _turnAnim.value),
//                     );
//                   })),
//         ],
//       ),
//     );
//   }
// }
