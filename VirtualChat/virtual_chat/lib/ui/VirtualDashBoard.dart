import 'package:flutter/material.dart';

class VirtualDashBoard extends StatefulWidget {
  @override
  _VirtualDashBoardState createState() => _VirtualDashBoardState();
}

class _VirtualDashBoardState extends State<VirtualDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Virtual Dashboard')
      ),
      body: Container(
        child: Center(
          child: Text(
            'Virtual Dashboard'
          )
        )
      )
    );
  }
}
