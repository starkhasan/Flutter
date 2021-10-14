import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/helpers.dart';
import 'package:notes_todo/utils/preferences.dart';

class AuthenticationProvider extends ChangeNotifier with Helpers {

  bool syncData = Preferences.getSyncEnabled();
  bool get isSyncEnabled => syncData;

  Future<void> loginUser(BuildContext _context, String email, String password) async {
    if (validation(_context, email, password)) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        Preferences.setUserEmail(email);
        Preferences.setUserLogin(true);
        Preferences.setUserID(userCredential.user!.uid);
        Preferences.setSyncEnabled(true);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    //2GrClgIMcjRHUsk1u8p3MrA4fNk1
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Preferences.setUserEmail('');
    Preferences.setUserLogin(false);
    Preferences.setUserID('');
    Preferences.setSyncEnabled(false);
  }

  void modifySyncData(){
    if(syncData){
      syncData = false;
      Preferences.setSyncEnabled(false);
    }else{
      syncData = true;
      Preferences.setSyncEnabled(true);
    }
    notifyListeners();
  }

  void deleteUserData() async{
    await FirebaseDatabase.instance.reference().child('notes').child(Preferences.getUserID()).child('task').remove();
    await FirebaseDatabase.instance.reference().child('notes').child(Preferences.getUserID()).child('completeTask').remove();
  }

  bool validation(BuildContext _context, String email, String password) {
    if (email.isEmpty) {
      showSnackBar(_context, 'Invalid Email');
      return false;
    } else if (password.isEmpty) {
      showSnackBar(_context, 'Invalid Password');
      return false;
    }else if(password.length < 6){
      showSnackBar(_context, 'Weak Password!!! Length of Password Should be atleast 6');
    }
    return true;
  }
}
