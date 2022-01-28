import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({ Key? key }) : super(key: key);

  @override
  _ImplicitAnimationState createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {

  double containerSize = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Implicit Animation',style: TextStyle(fontSize: 14))),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: containerSize,
                child: Image.asset('asset/dash.png'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => containerSize = containerSize == 250 ? 700 : 250), 
                child: const Text('Resize')
              )
            ]
          )
        )
      )
    );
  }
}