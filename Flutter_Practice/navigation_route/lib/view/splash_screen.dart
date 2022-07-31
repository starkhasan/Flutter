import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar()),
      body: const Center(child: Text('Navigator Route')),
    );
  }

  void startTimer(BuildContext context) => Timer(const Duration(seconds: 1), () => Navigator.pushReplacementNamed(context, '/main_screen'));
}
