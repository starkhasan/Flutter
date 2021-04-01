import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:hello_flutter/utils/Helper.dart';

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
    return Scaffold(
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
                  textInputAction: TextInputAction.done,
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
                  onSubmitted: (value) => _registerUser(),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => _registerUser(),
                  child: Text('Go'),
                ),
              ],
            ),
          ),
        );
  }

  void _registerUser() async {
    await Firebase.initializeApp();
    if (validation()) {
      try {
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassword.text);
        Preferences.setName(_controllerEmail.text);
        _controllerEmail.text = '';
        _controllerPassword.text = '';
        Helper.showToast("Account Created Successfully\n${userCredential.user.uid}" ,Colors.red);
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password')
          Helper.showToast("Password should be at least 6 characters" ,Colors.red);
        if (e.code == 'email-already-in-use')
          Helper.showToast('The email address is already in use by another account.' ,Colors.red);
      } catch (e) {
        print(e);
      }
    }
  }

  bool validation() {
    if (_controllerName.text.isEmpty) {
      Helper.showToast('Please provide name' ,Colors.red);
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      Helper.showToast('Please provide Email' ,Colors.red);
      return false;
    } else if (!EmailValidator.validate(_controllerEmail.text)) {
      Helper.showToast('Invalid Email' ,Colors.red);
      return false;
    } else if (_controllerPassword.text.isEmpty) {
      Helper.showToast('Please provide password' ,Colors.red);
      return false;
    } else if (_controllerPassword.text.length < 6) {
      Helper.showToast('Password should be at least 6 characters' ,Colors.red);
      return false;
    }
    return true;
  }
}
