import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_todo/view/notes_page.dart';
import 'package:notes_todo/utils/preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferences.init();
    startTimer(context);
    return const Scaffold(
      body: Center( child: Text('Splash Screen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
    );
  }

  startTimer(BuildContext _context) {
    Timer(const Duration(seconds: 2),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const NotesPage())));
  }
}
