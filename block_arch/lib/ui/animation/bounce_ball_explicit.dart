
import 'package:flutter/material.dart';

class BounceBallExplicit extends StatefulWidget {
  const BounceBallExplicit({ Key? key }) : super(key: key);

  @override
  _BounceBallExplicitState createState() => _BounceBallExplicitState();
}

class _BounceBallExplicitState extends State<BounceBallExplicit> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0,
      upperBound: 100
    );

    animationController.addListener(() {
      setState(() {
        
      });
    });

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bounce Ball Explicit')),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: animationController.value),
              height: 50,
              width: 50,
              decoration: const BoxDecoration(color: Colors.green,shape: BoxShape.circle)
            )
          )
        ]
      )
    );
  }
}