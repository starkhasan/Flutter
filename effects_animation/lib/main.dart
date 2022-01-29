import 'package:effects_animation/view/builtin_explicit_animated_widget/home_explicit_animted.dart';
import 'package:effects_animation/view/builtin_explicit_animated_widget/rotation_transition.dart';
import 'package:effects_animation/view/builtin_explicit_animated_widget/slide_transition_example.dart';
import 'package:effects_animation/view/builtin_explicit_animated_widget/size_transition.dart';
import 'package:effects_animation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:effects_animation/view/implicit_animation.dart';
import 'package:effects_animation/view/implicit_tween_animation.dart';

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
        '/implicit_animation': (context) => const ImplicitAnimation(),
        '/implicit_tween_animation': (context) => const ImplicitTweenAnimation(),
        '/explicit_built_animation': (context) => const HomeExplicitAnimated(),
        '/rotation_transition': (context) => const RotationTransitionExample(),
        '/slide_transition': (context) => const SlideTransitionExample(),
        '/size_transition': (context) => const SizeTransitionExample()
      }
    );
  }
}
