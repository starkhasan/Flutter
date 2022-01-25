import 'package:flutter/material.dart';

class UnderstandingConstraint extends StatefulWidget {
  const UnderstandingConstraint({ Key? key }) : super(key: key);

  @override
  _UnderstandingConstraintState createState() => _UnderstandingConstraintState();
}

class _UnderstandingConstraintState extends State<UnderstandingConstraint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Understanding Constraint')),
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red
        )
      )
    );
  }
}