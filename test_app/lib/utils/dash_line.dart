import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final String line;
  final Color lineColor;
  final String type;
  DashedLineVerticalPainter({required this.line, required this.lineColor,required this.type});
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashWidth = 5, dashSpace = 3, startY = 0, startX = 0;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    if (line == 'vertical') {
      if(type == 'solid') dashSpace = 0;
      while (startY < size.height) {
        canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
        startY += dashHeight + dashSpace;
      }
    } else {
      if(type == 'solid') dashSpace = 0;
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
