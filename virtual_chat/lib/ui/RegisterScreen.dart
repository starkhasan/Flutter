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
  var showPassword = true;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref().child('users');
    databaseReference.once().then((DatabaseEvent event){
      var data = event.snapshot.value as Map;
      if(data != null){
        for(var user in data.keys){
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
              'Create Account',
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
                  'Register',
                  style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)
                )
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By creating account, you are agree to our Terms & Services',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12,color: Colors.grey)
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
        'profile':'https://i.ibb.co/Tm8jmFY/add-1.png',
        'dob': ''
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
