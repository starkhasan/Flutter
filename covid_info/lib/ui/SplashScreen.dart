import 'dart:async';

import 'package:covid_info/ui/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.indigo[600],
      statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.jpg',height: MediaQuery.of(context).size.height * 0.14, width: MediaQuery.of(context).size.height * 0.14),
                  Text(
                    'Covid Info',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: '')
                  )
                ]
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Design & Developed by : Ali Hasan',
                      style: TextStyle(color: Colors.grey[300],fontWeight: FontWeight.bold,fontSize: 14)
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  startTimer() {
    Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard())));
  }
}
