import 'package:flutter/material.dart';

class SizeTransitionExample extends StatefulWidget {
  const SizeTransitionExample({Key? key}) : super(key: key);

  @override
  SizeTransitionExampleState createState() => SizeTransitionExampleState();
}

class SizeTransitionExampleState extends State<SizeTransitionExample> with SingleTickerProviderStateMixin{
  //SingleTickerProviderStateMixin is used to synchronize the animation behaviour of the device display
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..repeat();
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    super.initState();
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Size Transition',style: TextStyle(fontSize: 14))),
      body: Center(
        child: SizeTransition(
          sizeFactor: animation,
          axis: Axis.vertical,
          axisAlignment: -1,
          child: Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('asset/indian_navy_logo.png',width: MediaQuery.of(context).size.width * 0.40, height: MediaQuery.of(context).size.height * 0.30),
                  const Text('Indian Navy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35))
                ]
              )
            )
          )
        ),
      )
    );
  }
}
