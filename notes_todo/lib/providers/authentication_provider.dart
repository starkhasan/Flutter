import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/helpers.dart';
import 'package:notes_todo/utils/preferences.dart';

class AuthenticationProvider extends ChangeNotifier with Helpers {

  bool get isSyncEnabled => Preferences.getSyncEnabled();
  bool _syncDataDelete = false;
  bool _isLogin = false;
  bool _authProcess = false;
  bool _emailPaswordAvail = false;
  bool _showPassword = true;
  bool get isLoginUser => _isLogin;
  bool get isEmailPasswordAvail => _emailPaswordAvail;
  bool get showPassword => _showPassword;
  bool get isSyncDataDelete => _syncDataDelete;
  bool get isAuthProcess => _authProcess;
  UserCredential? userCredential;
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  var databaseReference = FirebaseDatabase.instance.ref().child('notes_todo');

  void turnSingIn(bool login, String name, String email, String password){
    _isLogin = login;
    fillEmailPassword(name, email, password);
    notifyListeners();
  }

  Future<void> userAuthenticate(bool isLogin,BuildContext _context,String name, String email, String password) async {
    if (await validation(_context,name, email, password)) {
      _authProcess = true;
      notifyListeners();
      try {
        isLogin
        ? userCredential = await firebaseAuthInstance.signInWithEmailAndPassword(email: email, password: password)
        : userCredential = await firebaseAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
        Preferences.setUserEmail(email);
        Preferences.setUserLogin(true);
        Preferences.setUserID(userCredential!.user!.uid);
        Preferences.setSyncEnabled(true);
        Preferences.setSyncExplicitly(true);
        if(!isLogin) databaseReference.child(userCredential!.user!.uid).update({'name' : name });
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

  Future<void> logoutUser(BuildContext _context) async {
    if(await checkInternetConnection()){
      await FirebaseAuth.instance.signOut();
      Preferences.setUserEmail('');
      Preferences.setUserLogin(false);
      Preferences.setUserID('');
      Preferences.setSyncEnabled(false);
      Preferences.setUserName('');
      Preferences.storeCompleteTask([]);
      Preferences.storeTask([]);
    }else{
      showSnackBar(_context, 'No Internet Connection');
    }
  }

  void modifySyncData(){
    if(Preferences.getSyncEnabled()){
      Preferences.setSyncEnabled(false);
    }else{
      Preferences.setSyncEnabled(true);
    }
    notifyListeners();
  }

  void deleteUserData(BuildContext _context) async{
    if(await checkInternetConnection()){
      _syncDataDelete = true;
      notifyListeners();
      await databaseReference.child(Preferences.getUserID()).child('task').remove();
      await databaseReference.child(Preferences.getUserID()).child('completeTask').remove();
      showSnackBar(_context, 'All Sync data has been deleted successfully');
      _syncDataDelete = false;
      notifyListeners();
    }else{
      showSnackBar(_context, 'No Internet Connection');
    }
  }

  void fillEmailPassword(String name,String email,String password){
    if(_isLogin){
      if(email.isNotEmpty && password.isNotEmpty){
        _emailPaswordAvail = true;
      }else{
        _emailPaswordAvail = false;
      } 
    }else{
      if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty){
        _emailPaswordAvail = true;
      }else{
        _emailPaswordAvail = false;
      }
    }
    notifyListeners();
  }

  void passwordVisibility(){
    _showPassword = _showPassword ? false : true;
    notifyListeners();
  }

  Future<bool> validation(BuildContext _context,String name, String email, String password) async{
    if(!_isLogin && name.isEmpty){
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
    }else if(!await checkInternetConnection()){
      showSnackBar(_context, 'No Internet Connection');
      return false;
    }
    return true;
  }
  
}
