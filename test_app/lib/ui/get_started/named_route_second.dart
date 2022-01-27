import 'package:flutter/material.dart';
import 'package:test_app/model/second_route_argument.dart';

class NamedRouteSecond extends StatefulWidget {
  static const routeName = '/extractArguments';
  const NamedRouteSecond({ Key? key}) : super(key: key);

  @override
  _NamedRouteSecondState createState() => _NamedRouteSecondState();
}

class _NamedRouteSecondState extends State<NamedRouteSecond> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SecondRouteArgument;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Second Route',style: TextStyle(fontSize: 14))),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(args.firstName+args.secondName)
        )
      )
    );
  }
}