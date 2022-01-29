import 'package:flutter/material.dart';

class FadeTransitionExample extends StatefulWidget {
  const FadeTransitionExample({Key? key}) : super(key: key);

  @override
  FadeTransitionExampleState createState() => FadeTransitionExampleState();
}

class FadeTransitionExampleState extends State<FadeTransitionExample> with SingleTickerProviderStateMixin{
  
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: const Duration(seconds: 2))..repeat(reverse: true);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
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
      appBar: AppBar(centerTitle: true,title: const Text('Fade Transition',style: TextStyle(fontSize: 14))),
      body: FadeTransition(
        opacity: animation,
        child: const FlutterLogo(size: 200)
      )
    );
  }
}
