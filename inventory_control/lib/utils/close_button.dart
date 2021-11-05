import 'package:flutter/material.dart';

class CloseButtonHelper extends StatelessWidget {
  const CloseButtonHelper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 6,bottom: 6,left: 6,right: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: Colors.red,width: 0.5)
      ),
      child: const Text('Close',style: TextStyle(color: Colors.red,fontSize: 10))
    );
  }
}