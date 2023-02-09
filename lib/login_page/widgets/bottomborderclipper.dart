import 'package:flutter/material.dart';

class BottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.1);
    var firstPoint = Offset(size.width * 0.7, size.height * 0.85);
    var secondPoint = Offset(size.width * 0.4, size.height * 0.25);
    var thirdPoint = Offset(size.width * 0.1, size.height);
    path.cubicTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy,
        thirdPoint.dx, thirdPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
