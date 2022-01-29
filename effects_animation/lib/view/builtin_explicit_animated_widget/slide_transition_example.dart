import 'package:flutter/material.dart';

class SlideTransitionExample extends StatefulWidget {
  const SlideTransitionExample({ Key? key }) : super(key: key);

  @override
  _SlideTransitionExampleState createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late final Animation<Offset> offsetAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    )..repeat();
    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0)
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
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
      appBar: AppBar(centerTitle: true,title: const Text('Slide Transition',style: TextStyle(fontSize: 14))),
      body: Center(
        child: SlideTransition(
          position: offsetAnimation,
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: FlutterLogo(size: 150),
          )
        ),
      )
    );
  }
}