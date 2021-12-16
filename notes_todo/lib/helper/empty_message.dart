import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final bool darkMode;
  const EmptyMessage({ Key? key,required this.darkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('To add Notes click on ',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12)),
            Icon(Icons.add_circle,size: 16,color: Theme.of(context).toggleableActiveColor),
            Text(' in bottom right corner',style: TextStyle(color: darkMode ? Colors.white : Colors.black,fontSize: 12))
          ]
        )
      )
    );
  }
}