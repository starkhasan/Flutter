import 'package:flutter/material.dart';

class NamedRouteSecond extends StatefulWidget {
  const NamedRouteSecond({ Key? key }) : super(key: key);

  @override
  _NamedRouteSecondState createState() => _NamedRouteSecondState();
}

class _NamedRouteSecondState extends State<NamedRouteSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Second Route',style: TextStyle(fontSize: 14))),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back')
        )
      )
    );
  }
}