import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_control/utils/helper.dart';
import 'package:inventory_control/utils/preferences.dart';

class AuthProvider extends ChangeNotifier with Helper{
  bool _isSignin = false;
  bool _authProcess = false;
  bool get userSignIn => _isSignin;
  UserCredential? userCredential;
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  void tabSignIn(bool value) {
    _isSignin = value;
    notifyListeners();
  }

  Future<void> userAuthenticate(BuildContext _context,String name, String email, String password) async {
    if (validation(_context,name, email, password)) {
      _authProcess = true;
      notifyListeners();
      try {
        _isSignin
        ? userCredential = await firebaseAuthInstance.signInWithEmailAndPassword(email: email, password: password)
        : userCredential = await firebaseAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
        Preferences.setLogin(true);
        Preferences.setInventoryName(name);
        Preferences.setUserId(userCredential!.user!.uid);
        if(!_isSignin) FirebaseDatabase.instance.reference().child('inventory_control').child(userCredential!.user!.uid).update({'name' : name });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(_context,'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(_context,'The account already exists for that email.');
        } else if (e.code == 'user-not-found') {
          showSnackBar(_context,'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSnackBar(_context,'Wrong password provided for that user.');
        }
      } catch (e) {
        showSnackBar(_context, e.toString());
      }
      _authProcess = false;
      notifyListeners();
    }
  }

  bool validation(BuildContext _context,String name, String email, String password) {
    if(!_isSignin && name.isEmpty){
      showSnackBar(_context, 'Please provider name');
      return false;
    }
    if (email.isEmpty) {
      showSnackBar(_context, 'Please provide email');
      return false;
    } else if(!validateEmail(email)){
      showSnackBar(_context, 'Invalid Email');
      return false;
    } else if (password.isEmpty) {
      showSnackBar(_context, 'Please provide password');
      return false;
    }else if(password.length < 6){
      showSnackBar(_context, 'Weak Password!!! Length of Password Should be atleast 6');
      return false;
    }
    return true;
  }
}
