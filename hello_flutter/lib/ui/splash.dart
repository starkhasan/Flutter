import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';


class Spalsh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _spalshState();
}

class _spalshState extends State<Spalsh> {
  
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Text(
            'Splash Screen',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
