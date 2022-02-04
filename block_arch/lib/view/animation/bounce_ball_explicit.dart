import 'package:flutter/material.dart';

class BounceBallExplicit extends StatefulWidget {
  const BounceBallExplicit({ Key? key }) : super(key: key);

  @override
  _BounceBallExplicitState createState() => _BounceBallExplicitState();
}

class _BounceBallExplicitState extends State<BounceBallExplicit>{

  final List<int> durations = [400,500,600];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bounce Ball Explicit')),
      body: Stack(
        children: [
          Center(
            child: Row(mainAxisSize: MainAxisSize.min,children: List.generate(3, (index) => BallLoading(ballDuration: durations[index])))
          )
        ]
      )
    );
  }
}

class BallLoading extends StatefulWidget {
  final int ballDuration;
  const BallLoading({ Key? key,required this.ballDuration}) : super(key: key);

  @override
  _BallLoadingState createState() => _BallLoadingState();
}

class _BallLoadingState extends State<BallLoading> with SingleTickerProviderStateMixin{
  
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.ballDuration),
      lowerBound: 0,
      upperBound: 100
    );

    animationController.addListener(() => setState(() {}));
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: animationController.value),
        height: 20,
        width: 20,
        decoration: const BoxDecoration(color: Colors.black,shape: BoxShape.circle)
      )
    );
  }
}