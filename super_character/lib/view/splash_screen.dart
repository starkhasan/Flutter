import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_character/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: const [
          Align(
            alignment: Alignment.center,
            child: Text('This is Splash Screen'),
          )
        ]
      ),
    );
  }

  startTimer(BuildContext _context){
    Timer(const Duration(seconds: 2),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}