import 'package:flutter/material.dart';
class DynamicLinkPage extends StatefulWidget {
  const DynamicLinkPage({ Key? key }) : super(key: key);

  @override
  _DynamicLinkPageState createState() => _DynamicLinkPageState();
}

class _DynamicLinkPageState extends State<DynamicLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dyanmic Link'),
      ),
      body: const Center(
        child: Text('Dynamic Link'),
      )
    );
  }
}