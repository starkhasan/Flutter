import 'package:fingerprint_auth/ui/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthenticationScreen> {

  var auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    clickLoginButton(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.lock,size: 40),
            const Text(
              "Confirm it's you",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            InkWell(
              onTap: () => clickLoginButton(context),
              child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: const [
                    Icon(Icons.fingerprint_sharp,size: 35),
                    Text(
                      "Touch the fingerprint sensor",
                      style: TextStyle(fontSize: 14,fontStyle: FontStyle.normal),
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

  void clickLoginButton(BuildContext context) async{
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if(canCheckBiometrics){
      //List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      bool authenticate = await auth.authenticate(localizedReason: 'Scan your fingerprint to authenticate');
      if(authenticate) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingScreen()));
      }
    }
  }
}
