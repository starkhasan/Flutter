import 'dart:async';

import 'package:covid_info/ui/Dashboard.dart';
import 'package:flutter/material.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Covid Info',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: '')
          )
        ),
      )
    );
  }

  startTimer() {
    Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard())));
  }
}
