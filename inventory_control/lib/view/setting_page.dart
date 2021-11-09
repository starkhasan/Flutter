import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Setting')
      ),
      body: const Center(
        child: Text('Setting'),
      ),
    );
  }
}