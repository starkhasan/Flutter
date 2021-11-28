import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_tracking/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    startTimer(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.location_pin,size: 40,color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Tracko',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
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
                      'Design & Developed by : Traversal',
                      style: TextStyle(color: Colors.grey[100],fontSize: 10)
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

  startTimer(BuildContext _context) {
    Timer(const Duration(seconds: 2),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}