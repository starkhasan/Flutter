import 'package:flutter/material.dart';

class TweenExplicit extends StatefulWidget {
  const TweenExplicit({ Key? key }) : super(key: key);

  @override
  State<TweenExplicit> createState() => _TweenExplicitState();
}

class _TweenExplicitState extends State<TweenExplicit> {

  final List<Duration> animationDuration = const [Duration(milliseconds: 400),Duration(milliseconds: 300),Duration(milliseconds: 500),Duration(milliseconds: 700)];
  
  bool isAnimate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Music Play Explicit Animation")),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.30),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(4, (index) => MainScreen(durations: animationDuration[index])),
            )
          ),
          Expanded(child: Container())
        ]
      )
    );
  }
}


class MainScreen extends StatefulWidget {
  final Duration durations;
  const MainScreen({ Key? key,required this.durations}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.durations,
      lowerBound: 15,
      upperBound: 95
    );    
    // final curveAnimation = CurvedAnimation(parent: animationController, curve: Curves.linear);
    // animation = Tween<double>(begin: 0, end: 100).animate(curveAnimation);
    animationController.addListener(() => setState(() {}));
    animationController.repeat(reverse: true);
  }

  bool changeAnimationController(String type) {
    if(type == 'stop'){
      animationController.reset();
      return false;
    }else{
      animationController.repeat(reverse: true);
      return true;
    }
  }

  @override
  void dispose() {
    animationController.dispose(); 
    super.dispose();
  }

  //music
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1,top: animationController.value),
      width: 15,
      decoration: const BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(topLeft: Radius.circular(1.0),topRight: Radius.circular(1.0))),
    );
  }
}