import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformUI extends StatefulWidget {
  @override
  _TransformUIState createState() => _TransformUIState();
}

class _TransformUIState extends State<TransformUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transform UI'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.none
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5
                  )
                ]
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  transform: Matrix4.translationValues(-10, -20, 0),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600],
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.white
                    )
                  )
                )
              )
            ),
            Transform.scale(
              //angle: math.pi / 4,
              scale: 0.5,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}