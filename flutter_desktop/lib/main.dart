import 'package:flutter/material.dart';
import '../../constants/font_path.dart';
import 'package:get/get.dart';
import 'constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: FontPath.montserrat,
        primarySwatch: Colors.blue
      ),
      initialRoute: Routes.splash,
      getPages: Routes.routes
    );
  }
}
