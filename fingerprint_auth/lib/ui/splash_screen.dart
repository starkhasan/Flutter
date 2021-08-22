import 'dart:async';

import 'package:fingerprint_auth/ui/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen')
      ),
    );
  }


  void startTimer(BuildContext context) => Timer(const Duration(seconds:  2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())));
}
