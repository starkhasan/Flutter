import 'package:flutter/material.dart';
import 'dart:math';

class TweenAnimationExample extends StatefulWidget {
  const TweenAnimationExample({ Key? key }) : super(key: key);

  @override
  _TweenAnimationExampleState createState() => _TweenAnimationExampleState();
}

class _TweenAnimationExampleState extends State<TweenAnimationExample> {

  double tweenEnd = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      tweenEnd = getrandomAngle();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => setState(() => tweenEnd = getrandomAngle()),
          child: Center(
            child: TweenAnimationBuilder<double>(
              curve: Curves.easeInOutBack,
              tween: Tween(end: tweenEnd,begin: 0), 
              duration: const Duration(seconds: 2), 
              builder: (context,angle,child){
                return Transform.rotate(
                  angle: angle,
                  child: Image.asset('assets/earth.png')
                );
              },
              child: Container(color: Colors.red,height: MediaQuery.of(context).size.height * 0.80,width: MediaQuery.of(context).size.width * 0.80),
            )
          )
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
          child: const Text('Tap Earth to Rotate',style: TextStyle(color: Colors.white,fontSize: 10,decoration: TextDecoration.none,fontFamily: '')),
        )
      ]
    );
  }

  double getrandomAngle(){
    return Random().nextDouble() * pi;
  }
}