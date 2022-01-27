import 'package:flutter/material.dart';

import '../../model/second_route_argument.dart';

class NamedRouteFirst extends StatefulWidget {
  const NamedRouteFirst({ Key? key }) : super(key: key);

  @override
  _NamedRouteFirstState createState() => _NamedRouteFirstState();
}

class _NamedRouteFirstState extends State<NamedRouteFirst> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('First Route',style: TextStyle(fontSize: 14))),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/extractArguments',arguments: SecondRouteArgument(firstName: 'Ali',secondName: ' Hasan')),
          child: const Text('Next')
        )
      )
    );
  }

}