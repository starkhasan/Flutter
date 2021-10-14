import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: 'To add Notes click on ',style: TextStyle(color: Colors.black)),
            TextSpan(text: '+',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 16)),
            TextSpan(text: ' button in bottom right corner',style: TextStyle(color: Colors.black))
          ]
        )
      )
    );
  }
}