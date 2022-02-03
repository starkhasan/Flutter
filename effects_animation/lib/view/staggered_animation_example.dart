import 'package:flutter/material.dart';

class StaggeredAnimationExample extends StatefulWidget {
  const StaggeredAnimationExample({Key? key}) : super(key: key);

  @override
  StaggeredAnimationExampleState createState() => StaggeredAnimationExampleState();
}

class StaggeredAnimationExampleState extends State<StaggeredAnimationExample>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Staggred Animation',style: TextStyle(fontSize: 14))),
      body: Container(
        color: Colors.red,
        child: const Center(child: Text('Staggred Animation')),
      )
    );
  }
}
