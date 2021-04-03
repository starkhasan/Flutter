import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hello_flutter/providers/LoginProvider.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
          child: Consumer<LoginProvider>(
            builder: (context,loginProvider,child){
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    TextField(
                      maxLines: 1,
                      controller: _controllerEmail,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value) => loginProvider.checkLoginField(_controllerEmail.text.toString(), _controllerPassword.text.toString()),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      obscureText: loginProvider.isPasswordVisible ? false : true,
                      showCursor: true,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      controller: _controllerPassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () => loginProvider.passwordVisible(),
                            icon:loginProvider.isPasswordVisible ? Icon(Icons.lock) : Icon(Icons.lock_open_rounded)
                          )),
                      onSubmitted: (value) => _registerUser(),
                      onChanged: (value) => loginProvider.checkLoginField(_controllerEmail.text.toString(), _controllerPassword.text.toString()),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginProvider.isFilled ? () => _registerUser() : null,
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10)
                      ),
                    ),
                  ],
                )
              );
            },
          )
        )
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
    if (_controllerEmail.text.isEmpty) {
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
