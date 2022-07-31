import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/home_screen'));
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar()),
      body: const Center(child: Text('Animation',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30))),
    );
  }
}
