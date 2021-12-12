import 'package:flutter/material.dart';

class TweenExplicit extends StatefulWidget {
  const TweenExplicit({ Key? key }) : super(key: key);

  @override
  _TweenExplicitState createState() => _TweenExplicitState();
}

class _TweenExplicitState extends State<TweenExplicit> with SingleTickerProviderStateMixin{
  
  late AnimationController _controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));
    animation = Tween(begin: 0.0, end: 300.0).animate(_controller);
    _controller.forward();

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              children: [
                Transform.translate(
                  child: Container(width: 100, height: 100, color: Colors.black),
                  offset: Offset(animation.value, 0),
                ),
                Transform.translate(
                  child: Container(width: 100, height: 100, color: Colors.red),
                  offset: Offset(animation.value, 0),
                )
              ]
            );
          }
        )
      )
    );
  }

}