import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/AddPets.dart';
import 'package:flutterapp/ui/BillingInformation.dart';
import 'package:flutterapp/ui/ForgotPassword.dart';
import 'package:flutterapp/ui/LandingPage.dart';
import 'package:flutterapp/ui/Pets.dart';
import 'package:flutterapp/ui/Signup.dart';
import 'package:flutterapp/ui/Verification.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:flutterapp/utils/drawer.dart';
import 'package:toast/toast.dart';

class NaturallyLogin extends StatefulWidget {
  @override
  _NaturallyLoginState createState() => _NaturallyLoginState();
}

class _NaturallyLoginState extends State<NaturallyLogin> {

  var dialog;
  bool remeberMe = false;
  bool visible = true;
  final focusNode = FocusNode();
  TextEditingController text1 = new TextEditingController();
  TextEditingController text2 = new TextEditingController();
  final bool isLoading=true;

  bool validation(){
    if(text1.text==""){
      Toast.show('Please Enter UserName',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(text2.text==""){
      Toast.show('Please Enter Password',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  void setVisible(){
    setState(() {
      visible = visible ? false : true;
    });
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['hash_code'] = '[aLRdAngCu2W]';
    map['device_token'] = 'etLH8gL6ljI:APA91bGs00_VrsrqpaaC9NKBiGKfQCh2msIz6H0szoahECQTCMOPQx-s1__fFNnh9EzSC5CwByc-8NiPeKURy_GQ3m0937QHO8XOLK2btLqf5_Kd2mQtY-yYmtYon2-Tvqk_f12Q-08H';
    map['device_type'] = 'android';
    map['username'] = text1.text.toString();
    map['password'] = text2.text.toString();
    var user = new Map();
    user['user']=map;
    return  ApiService.signin(user);
  }

  _clearPreferences(){
    Preferences.addUserId(0);
    Preferences.addToken("");
    Preferences.addName("");
    Preferences.addEmail("");
    Preferences.addPhone("");
    Preferences.addPassword("");
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Sign In',
        )
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:Image.asset(
                  'assets/images/banner.png',
                  fit:BoxFit.fill

                )
              ),
              SizedBox(height: 25.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email / Phone Number",
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child:TextField(
                      controller: text1,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular'),
                      decoration: InputDecoration(
                        hintText: "Enter UserName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      )
                    )
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child:TextField(
                      controller: text2,
                      obscureText: visible ? true : false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style:TextStyle(color:Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular'),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setVisible();
                          },
                          icon: visible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                          onChanged: (bool value) {
                            setState(() {
                              remeberMe = remeberMe ? false : true;
                            });
                          },
                          value: remeberMe
                        ),
                        Text(
                          'Remember Me',
                          style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context) => ForgotPassword())),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(int.parse("#144473".replaceAll("#", "0xff"))),fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30,0,30,0),
                child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,fontFamily: 'MontserratSemiBold'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(validation()){
                        dialog.show();
                        fetchData().then((result) {
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = FollohResponse.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              if(response.user.otpVerified){
                                _clearPreferences();
                                Preferences.addToken(response.user.token);
                                Preferences.addUserId(response.user.id);
                                Preferences.addPassword(text2.text.toString());
                                Preferences.addName(response.user.firstName+","+response.user.lastName);
                                Preferences.addPhone(response.user.phoneNo.toString());
                                Preferences.addEmail(response.user.email);
                                if(response.user.stepNo==1){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BillingInformation()));
                                }else if(response.user.stepNo == 2){
                                  if(response.user.temporaryPetsCount == 0){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPets()));
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Pets()));
                                  }
                                }else if(response.user.stepNo == 3){
                                  Preferences.setLogin(true);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
                                }
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
                              }
                            }else{
                              Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }
                          }else{
                          Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                        });
                      }
                    },
                  )
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Signup()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Color(int.parse("#144473".replaceAll("#", "0xff"))),fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}

