import 'package:flutter/material.dart';

class VirtualChatSetting extends StatefulWidget {
  @override
  _VirtualChatSettingState createState() => _VirtualChatSettingState();
}

class _VirtualChatSettingState extends State<VirtualChatSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: Colors.blue
      ),
      body: Container(
        child: Center(
          child: Text('Settings')
        )
      )
    );
  }
}