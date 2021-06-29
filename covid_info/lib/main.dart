import 'package:covid_info/ui/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Info',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplachScreen(),
    );
  }
}

