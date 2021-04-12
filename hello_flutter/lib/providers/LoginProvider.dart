import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/utils/ConnectivityDialog.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isFilled = false;
  bool isPasswordVisible = false;
  bool isGoogleSignIn = true;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void checkLoginField(String email, String password) {
    if (email != '' && password != '')
      isFilled = true;
    else
      isFilled = false;
    notifyListeners();
  }

  void passwordVisible() {
    isPasswordVisible = isPasswordVisible ? false : true;
    notifyListeners();
  }

  void loginUser(BuildContext _context, String email, String password) async {
    if (await Helper.isConnected()) {
      await Firebase.initializeApp();
      if (validation(email, password)) {
        try {
          var userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          Preferences.setName(email);
          Preferences.setLogin(true);
          Navigator.pushAndRemoveUntil(
              _context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Helper.showToast('No user found for that email.', Colors.red);
          } else if (e.code == 'wrong-password') {
            Helper.showToast(
                'Wrong password provided for that user.', Colors.red);
          }
        }
      }
    } else {
      showDialog(context: _context, builder: (context) => ConnectivityDialog());
    }
  }

  void googleLogin(BuildContext _context) async {
    if (await Helper.isConnected()) {
      isGoogleSignIn = false;
      notifyListeners();
      try {
        GoogleSignInAccount user = await googleSignIn.signIn();
        if (user != null) {
          isGoogleSignIn = true;
          notifyListeners();
          Preferences.setName(user.displayName);
          Preferences.setGoogleImage(user.photoUrl);
          Preferences.setLogin(true);
          Navigator.pushAndRemoveUntil(_context,MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
        }else{
          Helper.showToast('Please try again', Colors.red);
          notifyListeners();
        }
      } catch (error) {
        Helper.showToast(error.toString(), Colors.red);
        notifyListeners();
      }
    } else {
      showDialog(context: _context, builder: (context) => ConnectivityDialog());
    }
  }

  bool validation(String email, String password) {
    if (email.isEmpty) {
      Helper.showToast('Please provide Email', Colors.red);
      return false;
    } else if (!EmailValidator.validate(email)) {
      Helper.showToast('Invalid Email', Colors.red);
      return false;
    } else if (password.isEmpty) {
      Helper.showToast('Please provide password', Colors.red);
      return false;
    } else if (password.length < 6) {
      Helper.showToast('Password should be at least 6 characters', Colors.red);
      return false;
    }
    return true;
  }
}
