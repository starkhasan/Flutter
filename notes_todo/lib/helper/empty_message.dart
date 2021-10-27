import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final bool darkMode;
  const EmptyMessage({ Key? key,required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'To add Notes click on ',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12)),
            TextSpan(text: ' + ',style: TextStyle(color: Theme.of(context).toggleableActiveColor,fontWeight: FontWeight.bold,fontSize: 14)),
            TextSpan(text: ' button in bottom right corner',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12))
          ]
        )
      )
    );
  }
}