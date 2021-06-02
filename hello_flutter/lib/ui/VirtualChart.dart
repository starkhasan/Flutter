import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/VirtualDashBoard.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:lottie/lottie.dart';

class VirtualChart extends StatefulWidget {
  @override
  _VirtualChartState createState() => _VirtualChartState();
}

class _VirtualChartState extends State<VirtualChart> with WidgetsBindingObserver{
  var databaseReference;
  var paddingMainHeight = 0.0;
  var paddingMainWidth = 0.0;
  var paddingChildWidth = 0.0;
  var layoutMargin = 0.0;
  var _contID = TextEditingController();
  var _contPassword = TextEditingController();
  var passwordHide = true;
  var _listUser = [];
  var isLogin = true;
  var isUserFound = false;

  @override
  void initState() {
    Firebase.initializeApp();
    databaseReference = FirebaseDatabase.instance.reference().child('users');
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      for(var v in snapshot.value.keys) {
        _listUser.add(v);
      }
    });
    super.initState();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed)
      print('App is in Resume State');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    paddingMainHeight = MediaQuery.of(context).size.height * 0.15;
    paddingMainWidth = MediaQuery.of(context).size.width * 0.10;
    paddingChildWidth = MediaQuery.of(context).size.width * 0.05;
    layoutMargin = MediaQuery.of(context).size.width * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Virtual Chat',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Pattaya',
                            fontSize: 40
                          )
                        ),
                        Lottie.asset('assets/animationLottie/virtualChat.json',animate: true,width: 60,height: 60)
                      ]
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(paddingChildWidth, 0, paddingChildWidth, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _contID,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.verified_user),
                          hintText: 'User ID'
                        )
                      ),
                      SizedBox(height: layoutMargin),
                      TextField(
                        controller: _contPassword,
                        obscureText: passwordHide,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => setState((){ passwordHide ? passwordHide = false : passwordHide = true;}),
                            icon: Icon(passwordHide ? Icons.remove_red_eye : Icons.lock)
                          ),
                          hintText: 'Password',
                        ),
                        onSubmitted: (value) => userLogin(),
                      ),
                      SizedBox(height: layoutMargin),
                      CupertinoButton(
                        color: Colors.blue,
                        disabledColor: Colors.grey,
                        child: Text('Login'),
                        onPressed: () => userLogin()
                      ),
                      SizedBox(height: layoutMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Login',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                          Checkbox(
                            value: isLogin,
                            onChanged: (value) => setState((){isLogin = value;})
                          )
                        ]
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  void userLogin() async{
    if(validation()){
      if(isLogin){
        await databaseReference.once().then((DataSnapshot snapshot) {
          for(var v in snapshot.value.keys) {
            if(_contID.text == v && snapshot.value[v]['password'] == _contPassword.text){
              isUserFound = true;
            }
          }
        });
        if(isUserFound){
          showSnackBar('User Login Successfully');
          Preferences.setSenderName(_contID.text);
          Preferences.setVirtualLogin(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VirtualDashBoard()));
        }else{
          showSnackBar('Invalid UserID password');
        }
      }else{
        databaseReference.child(_contID.text).set({
          'about': 'Hey there! I am VirtualChat',
          'password': _contPassword.text,
          'profile':' '
        }).then((value){
          showSnackBar('User Registered Successfully');
          Preferences.setSenderName(_contID.text);
          Preferences.setVirtualLogin(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VirtualDashBoard()));
        }).catchError((value){
          showSnackBar('Something went wrong');
        });
      }
    }
  }


  bool validation() {
    if(_contID.text.isEmpty){
      showSnackBar('Invalid ID');
      return false;
    }else if(_contPassword.text.isEmpty){
      showSnackBar('Invalid Password');
      return false;
    }else if(_contPassword.text.length < 6){
      showSnackBar('Weak Password! Should be Atleast 6 Characters');
      return false;
    }else{
      if(isLogin){
        if(!_listUser.contains(_contID.text)){
          showSnackBar('User not Found! Please Registered After uncheck the checkbox');
          return false;
        }else
          return true;
      }else{
        if(_listUser.contains(_contID.text)){
          showSnackBar('User Already exist! Please Login After check the checkbox');
          return false;
        }else
          return true;
      }
    }
  }


  showSnackBar(String message){
    var snackBar = SnackBar(content: Text(message,style: TextStyle(color: Colors.white)),duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
