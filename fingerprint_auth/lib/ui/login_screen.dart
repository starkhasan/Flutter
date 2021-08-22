import 'dart:ui';

import 'package:fingerprint_auth/util/login_button.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var paddingLeftRight = 0.0;
  var auth = LocalAuthentication();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    paddingLeftRight = MediaQuery.of(context).size.width * 0.05;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(paddingLeftRight, 0, paddingLeftRight, 0),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/backLogin.jpg',),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey)
                      )
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey)
                      )
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: clickLoginButton,
                      child: const LoginButton(),
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  void clickLoginButton() async{
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if(canCheckBiometrics){
      //List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      bool authenticate = await auth.authenticate(localizedReason: 'Scan your fingerprint to authenticate');
      print(authenticate);
    }
  }
}
