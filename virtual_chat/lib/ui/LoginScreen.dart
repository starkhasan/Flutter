import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:virtual_chat/ui/RegisterScreen.dart';
import 'package:virtual_chat/ui/VirtualDashBoard.dart';
import 'package:virtual_chat/util/PreferenceUtil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var widthPadding = 0.0;
  var heightPadding = 0.0;
  var _idCont = TextEditingController();
  var _passCont = TextEditingController();
  var databaseReference;
  var _listUser = [];
  var isUserFound = false;
  var showPassword = true;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref().child('users');
    databaseReference.once().then((DatabaseEvent event){
      if(event.snapshot.value != null){
        var data = event.snapshot.value as Map;
        for(var user in data.keys){
          print(user);
          _listUser.add(user);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widthPadding = MediaQuery.of(context).size.width * 0.10;
    heightPadding = MediaQuery.of(context).size.height * 0.10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      padding: EdgeInsets.fromLTRB(widthPadding, heightPadding, widthPadding, heightPadding),
      color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Virtual Chat',style: TextStyle(fontFamily: 'Pattaya',fontSize: 30)),
            Text(
              'Welcome to VirtualChat',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 20),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _idCont,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'User ID',
                hintStyle: TextStyle(fontSize: 14)
              )
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passCont,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                obscureText: showPassword,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 14),
                  suffixIcon: IconButton(icon: showPassword ? Icon(Icons.lock_open_rounded) : Icon(Icons.lock),onPressed: () => setState((){showPassword = showPassword ? false : true;}))
                ),
              onSubmitted: (value) => userLogin(),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () => userLogin(),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.indigo
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)
                )
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Don't have account? ",style: TextStyle(color: Colors.black,fontSize: 12)),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(color: Colors.indigo,fontSize: 12),
                    recognizer:  TapGestureRecognizer()..onTap = (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    }
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  userLogin() async{
    if(validation()){
      await databaseReference.once().then((DatabaseEvent event) {
        var data = event.snapshot.value as Map;
        for(var v in data.keys) {
          if(_idCont.text == v && data[v]['password'] == _passCont.text){
            isUserFound = true;
            break;
          }
        }
      });
      if(isUserFound){
        showSnackBar('User Login Successfully');
        PreferenceUtil.setSenderName(_idCont.text);
        PreferenceUtil.setLogin(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VirtualDashBoard()));
      }else{
        showSnackBar('Invalid UserID or password');
      }
    }
  }

  bool validation(){
    if(_idCont.text.isEmpty){
      showSnackBar('Empty UserID');
      return false;
    }else if(_passCont.text.isEmpty){
      showSnackBar('Empty Password');
      return false;
    }else if(_passCont.text.length < 6){
      showSnackBar('Minimum length should be 6');
      return false;
    }else if(_listUser.isEmpty){
      showSnackBar('Please Register User First');
      return false;
    }
    return true;
  }

  showSnackBar(String message){
    var snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
