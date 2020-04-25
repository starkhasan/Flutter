import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/OtpResend.dart';
import 'package:flutterapp/ui/BillingInformation.dart';
import 'package:flutterapp/ui/NewPasswordActivity.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class Verification extends StatefulWidget {

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  TextEditingController contOTP = new TextEditingController();
  var dialog;
  int userId = 0;
  bool forgotPass = false;

  @override
  void initState(){
    Preferences.getUserId().then((onValue){
      setState(() {
        userId = onValue;
      });
    });
    Preferences.getForgot().then((onValue){
      setState(() {
        forgotPass = onValue;
      });
    });
    super.initState();
  }

  bool _validation(){
    if(contOTP.text.toString() == ""){
      Toast.show('Please provide OTP', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['user_id'] = userId;
    map['otp_code'] = contOTP.text.toString();
    var user = new Map();
    user['user']=map;
    return  ApiService.verifyOTP(user);
  }

  fetchOTP(){
    var map = new Map<String,dynamic>();
    map['user_id'] = userId;
    var user = new Map();
    user['user'] = map;
    return ApiService.resendOTP(user);
  }
  
  @override
  Widget build(BuildContext context) {
    dialog= CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Verify OTP',
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/images/banner.png',
                  fit:BoxFit.fill

                ),
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
                      controller: contOTP,
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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      dialog.show();
                      fetchOTP().then((result){
                        dialog.hide();
                        if(jsonDecode(result)['status'] == 200){
                            var response = OtpResend.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }else{
                              Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }  
                        }else{
                          Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                        }
                      });
                    }, 
                    child: Text(
                      'Resend',
                      style: TextStyle(color: Color(int.parse("#144473".replaceAll("#", "0xff"))),fontFamily: 'MontserratSemiBold',fontSize: 18.0),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(40,0,40, 0),
                child: SizedBox(
                  height: 45.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    child: Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,fontFamily: 'MontserratSemiBold'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(_validation()){
                        dialog.show();
                        fetchData().then((result){
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = FollohResponse.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              if(forgotPass){
                                Preferences.addForgot(false);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordActivity()));
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BillingInformation()));
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
                )
              ) 
            ]
          )
        ),
      )
    );
  }
}