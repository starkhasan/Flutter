import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/ui/RegisterUser.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var isVisible = false;
  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loadingText: 'Loading...',
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login User'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                TextField(
                  maxLines: 1,
                  controller: _controllerEmail,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 5),
                TextField(
                  obscureText: isVisible ? false : true,
                  showCursor: true,
                  maxLines: 1,
                  textInputAction: TextInputAction.go,
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = isVisible ? false : true;
                          });
                        },
                        icon: isVisible
                            ? Icon(Icons.lock)
                            : Icon(Icons.lock_open_rounded),
                      )),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => _loginUser(),
                  child: Text('Go'),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser())),
                  child: Text(
                    'Regsiter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _loginUser() async {
    await Firebase.initializeApp();
    if (validation()) {
      showProgressDialog();
      try {
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassword.text);
        dismissProgressDialog();
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dismissProgressDialog();
          _showToast('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          dismissProgressDialog();
          _showToast('Wrong password provided for that user.');
        }
      }
    }
  }

  bool validation() {
    if (_controllerEmail.text.isEmpty) {
      _showToast('Please provide Email');
      return false;
    } else if (!EmailValidator.validate(_controllerEmail.text)) {
      _showToast('Invalid Email');
      return false;
    } else if (_controllerPassword.text.isEmpty) {
      _showToast('Please provide password');
      return false;
    } else if (_controllerPassword.text.length < 6) {
      _showToast('Password should be at least 6 characters');
      return false;
    }
    return true;
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
