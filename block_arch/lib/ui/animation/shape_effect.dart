import 'dart:math';

import 'package:flutter/material.dart';

class ShapeEffect extends StatefulWidget {
  const ShapeEffect({ Key? key }) : super(key: key);

  @override
  _ShapeEffectState createState() => _ShapeEffectState();
}

class _ShapeEffectState extends State<ShapeEffect> {

  double margin = 0.0;
  double borderRadius = 0.0;
  Color shapeColor = Colors.red;
  bool isLogin = true;
  double loginButtonWidth = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    margin = getRandomMargin();
    borderRadius = getRandomBorderRadius();
    shapeColor = getRandomColor();
    loginButtonWidth = MediaQuery.of(context).size.width * 0.80;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shape Effect')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150 ,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                //Implicit animation also allow you to control changes to the rate of an animation within the duration
                //if you do not allow animation then implicit animation apply linear animation curve by default.
                curve: Curves.easeInOutBack,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: shapeColor,borderRadius: BorderRadius.circular(borderRadius)),
              )
            ),
            ElevatedButton(
              child: const Text('Change'),
              onPressed: () => {
                setState(() {
                  shapeColor = getRandomColor();
                  borderRadius = getRandomBorderRadius();
                })
              }
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => setState(() => {
                loginButtonWidth = isLogin ? MediaQuery.of(context).size.width * 0.12 : MediaQuery.of(context).size.width * 0.80,
                isLogin = isLogin ? false : true
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(10),
                width: loginButtonWidth,
                height: kToolbarHeight,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(isLogin ? 10 : 30))),
                child: isLogin ? const Center(child: Text('Login')) : const SizedBox(width: 35,child: CircularProgressIndicator(color: Colors.white))
              )
            )
          ]
        )
      )
    );
  }

  double getRandomMargin() {
    return Random().nextDouble() * 64;
  }

  double getRandomBorderRadius(){
    return Random().nextDouble() * 64;
  }

  Color getRandomColor(){
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}