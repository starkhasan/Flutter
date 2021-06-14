import 'package:flutter/material.dart';
import 'package:virtual_chat/ui/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: Duration(seconds: 5),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
    animation.addListener((){
      if(animation.isCompleted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    animation.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Text(
              'Virtual Chat',
              style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold,fontFamily: 'Pattaya')
            )
          )
        )
      ),
    );
  }
}
