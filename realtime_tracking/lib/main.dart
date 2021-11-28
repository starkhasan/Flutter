import 'package:flutter/material.dart';
import 'package:realtime_tracking/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Realtime Tracking',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen()
    );
  }
}
