import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  final String title;
  final String message;
  const OfferPage({Key? key,required this.title,required this.message}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer'),
        centerTitle: true,
      ),
      body: Center(child: Text(widget.message,style: const TextStyle(color: Colors.black)))
    );
  }
}
