import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Facebook Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool gmailLogin = false;
  bool isLoggedIn = false;
  String imageURL = 'http://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png';

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email','public_profile']);
     switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        var graphResponse = await Dio().get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${facebookLoginResult
        .accessToken.token}');
        var profile = json.decode(graphResponse.data);
        //print(profile.toString());
        setState(() {
          imageURL = profile['picture']['data']['url'];
        });
        onLoginStatusChanged(true);
        break;
    }
  }

  Future<String> signInWithGoogle() async{
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:20.0),
            Container(
              child: Center(
                child: isLoggedIn ? Text('Logged In') : RaisedButton(
                  child: Text("Login with Facebook"),
                  onPressed: () => initiateFacebookLogin(),
                )
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    imageURL
                  )
                )
              )
            ),
            SizedBox(height: 20.0),
            Container(
              child: Center(
                child: gmailLogin ? Text('Login Successfull') : RaisedButton(
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      print('Login SuccessFull');
                    });
                  },
                  child: Text('Gmail Login'),
                ),
              ),
            )
          ]
        )
      )
    );
  }
}
