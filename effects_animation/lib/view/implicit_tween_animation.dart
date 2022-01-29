import 'package:flutter/material.dart';
import 'dart:math' as math;

class ImplicitTweenAnimation extends StatefulWidget {
  const ImplicitTweenAnimation({ Key? key }) : super(key: key);

  @override
  _ImplicitTweenAnimationState createState() => _ImplicitTweenAnimationState();
}

class _ImplicitTweenAnimationState extends State<ImplicitTweenAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Implicit TweenAnimation',style: TextStyle(fontSize: 14)),),
      body: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0,end: math.pi * 2), 
              duration: const Duration(seconds: 1), 
              builder: (BuildContext context, double angle, Widget? child){
                return Transform.rotate(
                  angle: angle,
                  child: Image.asset('asset/dash.png')
                );
              }
            )
          )
        ]
      )
    );
  }
}