import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
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

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    databaseReference = FirebaseDatabase.instance.reference().child('users');
    databaseReference.once().then((DataSnapshot snapshot){
      for(var user in snapshot.value.keys){
        _listUser.add(user);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login'),
            SizedBox(height: 10),
            TextField(
              controller: _idCont,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'User ID'
              )
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passCont,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(icon: Icon(Icons.lock),onPressed: () => print('Click Here to Show Password'))
                ),
              onSubmitted: (value) => userLogin(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => userLogin(),
              child: Text('Login')
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
              child: Text(
                'Register User',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                )
              )
            )
          ]
        )
      )
    );
  }

  userLogin() async{
    if(validation()){
      await databaseReference.once().then((DataSnapshot snapshot) {
        for(var v in snapshot.value.keys) {
          if(_idCont.text == v && snapshot.value[v]['password'] == _passCont.text){
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
    }
    return true;
  }

  showSnackBar(String message){
    var snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
