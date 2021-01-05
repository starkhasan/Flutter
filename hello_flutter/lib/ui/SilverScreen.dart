import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SilverScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SilverScreen();
}

class _SilverScreen extends State<SilverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Silver Screen"),
        ),
      ),
    );
  }
}
