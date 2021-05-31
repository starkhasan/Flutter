import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends CustomPainter {
  final bool isSender;
  CustomChatBubble({this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = isSender ? Colors.blue : Colors.white;

    Path paintBubbleTail() {
      Path path;
      if (!isSender) {
        path = Path()
          ..moveTo(5, size.height)
          ..quadraticBezierTo(-5, size.height, -10, size.height)
          ..quadraticBezierTo(0, size.height - 5, 0, size.height - 17);
      }
      if (isSender) {
        path = Path()
          ..moveTo(size.width - 5, size.height - 4)
          ..quadraticBezierTo(0, size.height, size.width + 10, size.height)
          ..quadraticBezierTo(size.width, size.height - 5, size.width, size.height - 17);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(5));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
