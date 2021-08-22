import 'dart:async';
import 'package:fingerprint_auth/ui/authentication_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backLogin.jpg'),
                fit: BoxFit.cover
              )
            )
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'NetGym',
                    style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.bold,color: Colors.white)
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Addicted to getting',style: TextStyle(color: Colors.white)),
                        TextSpan(text: ' STRONG',style: TextStyle(color: Colors.yellow))
                      ]
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  void startTimer(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => const AuthenticationScreen()))
    );
  }

}
