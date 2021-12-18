import 'dart:async';
import 'package:super_character/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.indigo));
    startTimer(context);
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text('Super Character',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
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
                    style: TextStyle(color: Colors.grey[200],fontSize: 11)
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  startTimer(BuildContext _context) {
    Timer(const Duration(seconds: 2),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}
