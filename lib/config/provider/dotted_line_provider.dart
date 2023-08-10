import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.8; // Width of the line

    // Define the spacing and dash pattern for the dotted line
    final double dashWidth = 4;
    final double dashSpace = 5;

    double currentX = 0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashWidth, 0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
