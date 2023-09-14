import 'package:flutter/material.dart';

class CurveShadowPainter extends CustomPainter {
  final double startAngle;
  final double angleRange;

  CurveShadowPainter({required this.startAngle, required this.angleRange});

  @override
  void paint(Canvas canvas, Size size) {
    double elevate = -20;
    double bezierHeight = size.height;
    Path bezierPath = Path()
      ..moveTo(elevate, bezierHeight / 3)
      ..quadraticBezierTo(
        size.width / 2,
        -bezierHeight / 3,
        size.width + elevate.abs(),
        bezierHeight / 3,
      )
      ..lineTo(size.width, bezierHeight / 3 * 2)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        elevate,
        bezierHeight / 3 * 2,
      )
      ..lineTo(elevate, bezierHeight / 3);
    canvas.drawShadow(bezierPath, const Color(0xFF171A26), elevate.abs(), true);
    canvas.drawShadow(bezierPath, const Color(0xFF171A26), elevate.abs(), true);
    canvas.drawShadow(bezierPath, const Color(0xFF171A26), elevate.abs(), true);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
