import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({ Key? key }) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Landing Page'),
      ),
      body: const Center(child: Text('Welcome Back!!!'))
    );
  }
}