import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final String line;
  DashedLineVerticalPainter({required this.line});
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashWidth = 5,dashSpace = 3, startY = 0, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    if(line == 'vertical'){
      while (startY < size.height) {
        canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
        startY += dashHeight + dashSpace;
      }
    }else{
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    }    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}