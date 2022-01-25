import 'package:flutter/material.dart';
import 'package:test_app/ui/get_started/named_route_second.dart';

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
          onPressed: () => Navigator.pushNamed(context, '/get_started/second'),
          child: const Text('Next')
        )
      )
    );
  }
}