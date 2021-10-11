import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_todo/ui/notes_page.dart';
import 'package:notes_todo/utils/preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferences.init();
    startTimer(context);
    return Scaffold(
      body: Container(child: const Center( child: Text('Splash Screen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)))),
    );
  }

  startTimer(BuildContext _context) {
    Timer(const Duration(seconds: 3),() => Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => const NotesPage())));
  }
}
