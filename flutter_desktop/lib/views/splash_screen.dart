import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/constants/font_path.dart';
import 'package:flutter_desktop/constants/image_path.dart';
import 'package:flutter_desktop/constants/routes.dart';
import 'package:flutter_desktop/constants/strings.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => Get.offAllNamed(Routes.loginScreen));
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ImagePath.appLogo, width: Get.width * 0.20, height: Get.height * 0.20),
            const SizedBox(height: 10),
            const Text(
              Strings.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none, 
                fontFamily: FontPath.montserratSemiBole, 
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}