import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtual_chat/ui/VirtualDashBoard.dart';
import 'package:virtual_chat/util/PreferenceUtil.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            Text('Register User'),
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
              child: Text('Register')
            )
          ]
        )
      )
    );
  }

  userLogin() async{
    if(validation()){
      databaseReference.child(_idCont.text).set({
        'about': 'Hey there! I am using VirtualChat',
        'password': _passCont.text,
        'profile':' ',
        'message':'',
        'lastActive':''
      }).then((value){
        showSnackBar('User Registered Successfully');
        PreferenceUtil.setSenderName(_idCont.text);
        PreferenceUtil.setLogin(true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VirtualDashBoard()), (route) => false);
      }).catchError((value){
        showSnackBar('Something went wrong');
      });
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
    }else if(_listUser.contains(_idCont.text)){
      showSnackBar('User Already Exist');
      return false;
    }
    return true;
  }

  showSnackBar(String message){
    var snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
