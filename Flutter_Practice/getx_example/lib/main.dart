import 'package:flutter/material.dart';
import 'package:getx_example/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //creating navigator to manage the route using MaterialApp
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.ounter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      ///home (MyHomePage) become the route at the bottom of Navigator's Stack
      home: const SplashScreen(),
    );
  }
}
