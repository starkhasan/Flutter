import 'package:flutter/material.dart';

class WidgetDemo extends StatefulWidget {
  @override
  _WidgetDemoState createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Widget Demo'),
      ),
      body: Container(
        child: Center(child: Text('Download File From')),
      )
    );
  }
}
