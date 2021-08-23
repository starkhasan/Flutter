import 'package:covid_info/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  var materialColor = MaterialColor(0xff0B3054, <int, Color>{
    50: const Color(0xFF0B3054),
    100: const Color(0xFF0B3054),
    200: const Color(0xFF0B3054),
    300: const Color(0xFF0B3054),
    400: const Color(0xFF0B3054),
    500: const Color(0xFF0B3054),
    600: const Color(0xFF0B3054),
    700: const Color(0xFF0B3054),
    800: const Color(0xFF0B3054),
    900: const Color(0xFF0B3054)
  });
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Info',
      theme: ThemeData(
        primarySwatch: materialColor
      ),
      home: SplashScreen(),
    );
  }
}
