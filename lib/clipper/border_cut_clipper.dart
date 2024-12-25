import 'package:flutter/material.dart';

class BorderCutClipper extends CustomClipper<Path> {
  double thickness;
  double radius;
  BorderCutClipper({
    required this.thickness,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
        -size.width, -size.width, size.width * 2, size.height * 2);
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    final borderPath = Path();
    borderPath.fillType = PathFillType.evenOdd;
    borderPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(thickness, thickness, width, height),
        Radius.circular(radius - thickness)));
    borderPath.addRect(rect);

    return borderPath;
  }

  @override
  bool shouldReclip(BorderCutClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}
