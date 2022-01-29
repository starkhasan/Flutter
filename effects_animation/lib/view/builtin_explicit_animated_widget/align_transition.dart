import 'package:flutter/material.dart';

class AlignTransitionExample extends StatefulWidget {
  const AlignTransitionExample({Key? key}) : super(key: key);

  @override
  AlignTransitionExampleState createState() => AlignTransitionExampleState();
}

class AlignTransitionExampleState extends State<AlignTransitionExample> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<AlignmentGeometry> animationAlignGeometry;
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    )..repeat();
    animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animationAlignGeometry = Tween<AlignmentGeometry>(
      begin: Alignment.bottomLeft,
      end: Alignment.center
    ).animate(animation);
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
      appBar: AppBar(centerTitle: true,title: const Text('Align Transition')),
      body: AlignTransition(
        alignment: animationAlignGeometry,
        child: const FlutterLogo(size: 200)
      )
    );
  }
}
