import 'package:flutter_desktop/views/signup_screen.dart';

import '../../views/home_screen.dart';
import '../../views/login_screen.dart';
import '../../views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  Routes._();

  static const String splash = '/';
  static const String homeScreen = '/home_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen())
  ];
}