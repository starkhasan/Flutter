import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final bool darkMode;
  const EmptyMessage({ Key? key,required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Click on ',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12)),
              Icon(Icons.add_circle,size: 16,color: Theme.of(context).toggleableActiveColor),
              Text(' to add Notes',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12))
            ]
          )
        )
      )
    );
  }
}