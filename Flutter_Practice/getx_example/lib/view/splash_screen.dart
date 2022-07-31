import 'package:flutter/material.dart';
import 'package:getx_example/view/home_screen.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen())));
    return Scaffold(
      appBar: PreferredSize(child: AppBar(), preferredSize: const Size.fromHeight(0)),
      body: const Center(child: Text('GetX',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
    );
  }

}
