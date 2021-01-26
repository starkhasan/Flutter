import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  
  var isVisible = false;
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loadingText: 'Loading...',
        child: Scaffold(
          appBar: AppBar(
            title: Text('Register User'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                TextField(
                  maxLines: 1,
                  controller: _controllerName,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                SizedBox(height: 5),
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
                  onPressed: () => _registerUser(),
                  child: Text('Go'),
                ),
              ],
            ),
          ),
        ));
  }

  void _registerUser() async {
    await Firebase.initializeApp();
    if (validation()) {
      showProgressDialog();
      try {
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassword.text);
        dismissProgressDialog();
        Preferences.setName(_controllerEmail.text);
        _controllerEmail.text = '';
        _controllerPassword.text = '';
        _showToast("Account Created Successfully\n${userCredential.user.uid}");
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      } on FirebaseAuthException catch (e) {
        dismissProgressDialog();
        if (e.code == 'weak-password')
          _showToast("Password should be at least 6 characters");
        if (e.code == 'email-already-in-use')
          _showToast('The email address is already in use by another account.');
      } catch (e) {
        dismissProgressDialog();
        print(e);
      }
    }
  }

  bool validation() {
    if (_controllerName.text.isEmpty) {
      _showToast('Please provide name');
      return false;
    } else if (_controllerEmail.text.isEmpty) {
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
