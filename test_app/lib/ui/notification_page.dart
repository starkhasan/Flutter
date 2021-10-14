import 'package:flutter/material.dart';

class NotificatonPage extends StatefulWidget {
  final String title;
  final String message;
  const NotificatonPage({ Key? key,required this.title, required this.message}) : super(key: key);

  @override
  _NotificatonPageState createState() => _NotificatonPageState();
}

class _NotificatonPageState extends State<NotificatonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: Center(child: Text(widget.message,style: const TextStyle(color: Colors.black)))
    );
  }
}