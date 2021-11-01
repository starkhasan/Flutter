import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:inventory_control/view/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitUp]);
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
                children: [
                  Image.asset('asset/app_icon.png',height: MediaQuery.of(context).size.height * 0.12, width: MediaQuery.of(context).size.height * 0.12),
                  const Text(
                    'Inventory',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
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
    Timer(const Duration(seconds: 3),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const HomePage())));
  }
}