import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  const RippleEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('RippleEffect')),
      body: Container(
        color: Colors.white,
        child: InkWell(
          onTap: () => print('Click Here to Perform the Effect'),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue,
            child: const Center(child: Text('Click'))
          )
        )
      )
    );
  }
}
