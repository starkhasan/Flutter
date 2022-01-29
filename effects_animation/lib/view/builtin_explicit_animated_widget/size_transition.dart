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
      duration: const Duration(seconds: 2)
    )..repeat();
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Size Transition',style: TextStyle(fontSize: 14))),
      body: Container(
        child: Center(
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            axisAlignment: 0,
            child: const FlutterLogo(size: 200),
          ),
        )
      )
    );
  }
}
