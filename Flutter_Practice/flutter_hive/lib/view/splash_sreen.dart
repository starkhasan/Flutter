import 'package:flutter/material.dart';
import 'dart:async';
class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/main_sceen'));
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar()),
      body: const Center(child: Text('Flutter Hive',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)))
    );
  }
}