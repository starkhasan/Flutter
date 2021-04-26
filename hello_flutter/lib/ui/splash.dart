import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/LoginUser.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class Spalsh extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Spalsh> {
  var isLogin = false;
  var messages = RemoteMessage();
  @override
  void initState() {
    super.initState();
    Preferences.getLogin().then((value) {
      setState(() {
        isLogin = value;
      });
    });
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 2), () {
      if (isLogin) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUser()));
      }
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
