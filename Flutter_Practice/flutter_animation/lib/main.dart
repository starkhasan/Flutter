import 'package:flutter/material.dart';
import 'package:flutter_animation/view/container_transform.dart';
import 'package:flutter_animation/view/home_screen.dart';
import 'package:flutter_animation/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/container_transform': (context) => const ContainerTransform()
      },
    );
  }
}
