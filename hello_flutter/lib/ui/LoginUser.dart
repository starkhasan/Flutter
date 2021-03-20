import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/ui/RegisterUser.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerPhone = TextEditingController();
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
                  onSubmitted: (value) => _loginUser(),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => _loginUser(),
                  child: Text('Go'),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterUser())),
                  child: Text(
                    'Regsiter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: false,
                  controller: _controllerPhone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Enter your number',
                    hintStyle: TextStyle(
                      color: Colors.grey[400]
                    ),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide()
                    )
                  ),
                  onFieldSubmitted: (value) {
                    value.length != 10
                      ? Helper.showToast('Please provide valid mobile number'  ,Colors.red)
                      : _verifyPhoneAuth(value);
                  },
                )
              ],
            ),
          ),
        ));
  }

  void _verifyPhoneAuth(String phone) async{
    showProgressDialog();
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: '+91 '+phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        dismissProgressDialog();
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException e){
        dismissProgressDialog();
        Helper.showToast(e.message  ,Colors.red);
      },
      codeSent: (String verificationId, int resendToken) async{
        dismissProgressDialog();
        Preferences.setName(_controllerPhone.text);
        String smsCode = '564781';
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        var user = await auth.signInWithCredential(phoneAuthCredential);
        Helper.showToast('User Signned in Successfully with $verificationId'  ,Colors.red);
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
      codeAutoRetrievalTimeout: (String verificationId){
        dismissProgressDialog();
      }
    );
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
        Preferences.setName(_controllerEmail.text);
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dismissProgressDialog();
          Helper.showToast('No user found for that email.'  ,Colors.red);
        } else if (e.code == 'wrong-password') {
          dismissProgressDialog();
          Helper.showToast('Wrong password provided for that user.'  ,Colors.red);
        }
      }
    }
  }

  bool validation() {
    if (_controllerEmail.text.isEmpty) {
      Helper.showToast('Please provide Email'  ,Colors.red);
      return false;
    } else if (!EmailValidator.validate(_controllerEmail.text)) {
      Helper.showToast('Invalid Email'  ,Colors.red);
      return false;
    } else if (_controllerPassword.text.isEmpty) {
      Helper.showToast('Please provide password'  ,Colors.red);
      return false;
    } else if (_controllerPassword.text.length < 6) {
      Helper.showToast('Password should be at least 6 characters'  ,Colors.red);
      return false;
    }
    return true;
  }
}
