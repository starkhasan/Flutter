import 'package:flutter/material.dart';

class RotationTransitionExample extends StatefulWidget {
  const RotationTransitionExample({ Key? key}) : super(key: key);

  @override
  _RotationTransitionExampleState createState() => _RotationTransitionExampleState();
}

class _RotationTransitionExampleState extends State<RotationTransitionExample> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this
    )..repeat();
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
      appBar: AppBar(centerTitle: true,title: const Text('Rotation Transition',style: TextStyle(fontSize: 14))),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black,
            child: RotationTransition(
              child: Image.asset('asset/galactic_proportions.png'),
              alignment: Alignment.center,
              turns: animationController,
            )
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () => animationController.repeat(), 
                    child: const Text('Play')
                  ),
                  ElevatedButton(
                    onPressed: () => animationController.stop(), 
                    child: const Text('Pause')
                  ),
                  ElevatedButton(
                    onPressed: () => animationController.reset(), 
                    child: const Text('Stop')
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}