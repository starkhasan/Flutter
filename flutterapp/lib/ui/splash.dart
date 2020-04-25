import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/ui/LandingPage.dart';
import 'package:flutterapp/utils/Preferences.dart';

import 'NaturallyLogin.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool login;
  @override
  void initState() {
    Preferences.getLogin().then((onValue){
      setState(() {
        login = onValue;
      });
    });
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Image.asset('assets/images/follohbanner.jpg'),
        )
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    if(login){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage()));
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => NaturallyLogin()));
    }
  }
}