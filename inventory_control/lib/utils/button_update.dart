import 'package:flutter/material.dart';

class ButtonUpdate extends StatelessWidget {
  const ButtonUpdate({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: const Center(child: Text('Update',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white))),
    );
  }
}