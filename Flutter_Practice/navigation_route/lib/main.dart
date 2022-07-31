import 'package:flutter/material.dart';
import 'package:navigation_route/view/home_screen.dart';
import 'package:navigation_route/view/splash_screen.dart';
import 'package:navigation_route/view/main_screen.dart';
import 'package:navigation_route/view/user_details.dart';
import 'package:navigation_route/view/user_form.dart';
import 'package:navigation_route/view/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const SplashScreen(),
        '/main_screen':(context) => const MainScreen(),
        '/home_screen':(context) => const HomeScreen(),
        '/user_registration':(context) => const UserRegistration(),
        '/user_details':(context) => const UserDetails(),
        '/counter_screen': (context) => const CounterScreen()
      },
    );
  }
}
