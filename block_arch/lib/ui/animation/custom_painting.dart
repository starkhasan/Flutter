import 'package:flutter/material.dart';

class CustomPainting extends StatefulWidget {
  const CustomPainting({ Key? key }) : super(key: key);
  @override
  _CustomPaintingState createState() => _CustomPaintingState();
}

class _CustomPaintingState extends State<CustomPainting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Painting'),centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: CustomPaint(painter: HorizontalLine()),
            )
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.pink,
              child: CustomPaint(painter: CircularPaint()),
            )
          )
        ]
      )
    );
  }
}


class HorizontalLine extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    double startX = 20.0;
    double startY = 20.0;
    double spaceWidth = 5.0;
    double dashWidth = 5.0;
    final paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2;
    canvas.drawLine(const Offset(20,20), Offset(size.width - 20,20),paint);
    canvas.drawLine(Offset(size.width - 20, 20), Offset(size.width - 20,size.height - 20), paint); 
    canvas.drawLine(Offset(size.width - 20,size.height - 20), Offset(20,size.height - 20), paint);
    canvas.drawLine(Offset(20,size.height - 20),const Offset(20,20), paint);

    while(startX < size.width - 20){
      canvas.drawLine(Offset(startX, size.height / 2), Offset(startX + dashWidth,size.height / 2), paint);
      startX += dashWidth + spaceWidth;
    }

    while(startY < size.height - 20){
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2,startY + dashWidth), paint);
      startY += dashWidth + spaceWidth;
    }
    //draw a solid rectangle
    canvas.drawRect(Rect.fromPoints( Offset(size.width / 3,size.height / 3), Offset(size.width / 1.5, size.height / 1.5)), Paint()..color = Colors.red);
    //drawing a solid rectangle with from its left top right bottom edges with only edge
    canvas.drawRect(Rect.fromLTRB(50, 50, size.width - 50, size.height - 50), Paint()..style = PaintingStyle.stroke..color = Colors.pink..strokeWidth = 5);
  }

  //this method is called when new instance of the class is provided, to check if new instance actually represent different information
  //if new instance is not provided or you draw it for only once then retun false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class CircularPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2 - 20;
    canvas.drawCircle(Offset(size.width / 2,size.height / 2), radius, Paint()..style = PaintingStyle.stroke..color = Colors.white..strokeWidth = 2);
    canvas.drawLine(Offset(size.width / 2 , size.height /2), Offset(size.width/1.25,size.height / 2), Paint()..color = Colors.white..strokeWidth = 2);

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}