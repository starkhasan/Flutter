import 'package:effects_animation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:effects_animation/view/implicit_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Effect Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/implicit_animation': (context) => const ImplicitAnimation()
      }
    );
  }
}
