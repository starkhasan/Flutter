import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BounceBallImplicit extends StatefulWidget {
  const BounceBallImplicit({ Key? key }) : super(key: key);

  @override
  _BounceBallImplicitState createState() => _BounceBallImplicitState();
}

class _BounceBallImplicitState extends State<BounceBallImplicit> {

  double topMargin = 0.0;
  double ballSize = 0.0;
  Color ballColor = Colors.red;
  late Timer ballBouncingTimer;


  @override
  void initState() {
    super.initState();
    ballSize = 10;
    ballBouncingTimer = Timer.periodic(const Duration(milliseconds: 700), changePosition);
  }


  void changePosition(Timer t){
    setState(() {
      ballColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      topMargin = topMargin == 0 ? 200 : 0;
    });
  }

  @override
  void dispose() {
    ballBouncingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bounce Ball Implicit')),
      body: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 700),
              height: ballSize,
              width: ballSize,
              margin: EdgeInsets.only(bottom: topMargin),
              decoration: BoxDecoration(color: ballColor,shape: BoxShape.circle)
            )
          ),
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Slider(
                label: "Size ${ballSize.toInt()}",
                divisions: 10,
                value: ballSize, 
                max: 100,
                min: 0,
                onChanged: (value) => setState(() => ballSize = value)
              ),
            ),
          )
        ],
      )
    );
  }
  
}