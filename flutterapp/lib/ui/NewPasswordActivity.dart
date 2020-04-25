import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/BillingInformation.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class NewPasswordActivity extends StatefulWidget {
  @override
  _NewPasswordActivityState createState() => _NewPasswordActivityState();
}

class _NewPasswordActivityState extends State<NewPasswordActivity> {

  int userId = 0;
  String token = "";

  @override
  void initState(){
    Preferences.getUserId().then((onValue){
      setState(() {
        userId = onValue;
      });
    });
    Preferences.getToken().then((result){
      setState(() {
        token = result;
      });
    });
    super.initState();
  }

  var dialog;
  bool visible;
  TextEditingController contNewPass = new TextEditingController();
  TextEditingController contConfPass = new TextEditingController();

  void setVisible(){
    setState(() {
      visible = visible ? false : true;
    });
  }

  bool validation(){
    if(contNewPass.text.toString()==""){
      Toast.show('Please provide password',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contConfPass.text.toString()!=contNewPass.text.toString()){
      Toast.show('Passwords does not matches.',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['password'] = contConfPass.text.toString();
    map['user_id'] = userId;
    var user = new Map();
    user['user']=map;
    return  ApiService.updateProfile(user);
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Change Password',
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
                    "New Password",
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child:TextField(
                      controller:contNewPass,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular'),
                      decoration: InputDecoration(
                        hintText: "Enter Your New Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      )
                    )
                  )
                ]
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Confirm Password',
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    child:TextField(
                      controller: contConfPass,
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
                        hintText: 'Confirm Your Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      )
                    )
                  )
                ]
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.fromLTRB(30,0,30,0),
                child: SizedBox(
                  height: 45.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,fontFamily: 'MontserratSemiBold'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
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
                              if(response.user.stepNo == 1){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BillingInformation()));
                                Preferences.addToken(response.user.token);
                              }else if(response.user.stepNo==2){
                                /*Preferences.isSignUp=true
                                if(response.user.temporary_pets_count>0){
                                  startActivity(Intent(this,PetActivity::class.java))
                                  Preferences.auth=response.user.token
                                }else{
                                  startActivity(Intent(this,AddPetActivity::class.java))
                                  Preferences.auth=response.user.token
                                  finish()
                                }*/
                              }else if(response.user.stepNo==3){
                                  /*val intent = Intent(this@NewPasswordActivity,LandingPageActivity::class.java)
                                  intent.flags =Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_CLEAR_TASK
                                  startActivity(intent)
                                  Preferences.auth=response.user.token
                                  Preferences.isLogin=true
                                  Preferences.isSignUp=false
                                  finish()*/
                              }
                            }else{
                              Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }
                          }else{
                          Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                        });
                      }
                    }
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}