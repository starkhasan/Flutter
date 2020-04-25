import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/NaturallyLogin.dart';
import 'package:flutterapp/ui/Verification.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var dialog;
  TextEditingController email = new TextEditingController();

  bool _validation(){
    if(email.text.toString() == ""){
      Toast.show('Please provide valid username', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else{
      return true;
    }
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['username'] = email.text.toString();
    var user = new Map();
    user['user']=map;
    return  ApiService.forgetPassword(user);
  }

  @override
  Widget build(BuildContext context) {
    dialog = dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Color(int.parse("#144473".replaceAll("#", "0xff"))),
        title: Text(
          'Forgot Password'
        )
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                child:Image.asset(
                  'assets/images/banner.png',
                  fit:BoxFit.fill

                )
              ),
              SizedBox(height: 20.0),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email / Phone Number',
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: email,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email / Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: Colors.black)
                          )
                        )
                      )
                    )
                  ]
                )
              ),
              SizedBox(height:10.0),
              Container(
                child: RichText(
                 text: TextSpan(
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratLight',fontSize: 11.0),
                  children: <TextSpan>[
                    TextSpan(text:"Enter your Email / Phone Number and we'll send you a code to change your password."),
                  ]
                 ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(40,0,40,0),
                child: SizedBox(
                  height: 45.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(_validation()){
                        dialog.show();
                        fetchData().then((result){
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = FollohResponse.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              Preferences.addUserId(response.user.id);
                              Preferences.addForgot(true);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
                            }else{
                              Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }
                          }else{
                          Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    )
                  )
                )
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Know your password ? ',
                    style: TextStyle(color: Colors.black,fontFamily:'MontserratRegular',fontSize: 14.0),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NaturallyLogin()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Color(int.parse("#144473".replaceAll("#", "0xff"))),fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                    )
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }
}