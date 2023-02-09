import 'package:flutter/material.dart';

class TopBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path()..moveTo(0, 0);
    path.lineTo(size.width, 0);
    var firstPoint = Offset(size.width * 0.2, size.height * 0.2);
    var secondPoint = Offset(size.width * 0.6, size.height * 0.7);
    var thirdPoint = Offset(0, size.height);
    path.cubicTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy,
        thirdPoint.dx, thirdPoint.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
