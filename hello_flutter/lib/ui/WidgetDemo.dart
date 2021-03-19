import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/Helper.dart';

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
        title: Text('This is center title'),
      ),
      body: Container(
        child: Center(
          child: Helper.showToast('This is ali hasan', context, Colors.green)
        ),
      ),
    );
  }
}