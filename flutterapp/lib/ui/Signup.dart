import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/Verification.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController contFirstName = new TextEditingController();
  TextEditingController contLastName = new TextEditingController();
  TextEditingController contEmail = new TextEditingController();
  TextEditingController contPhone = new TextEditingController();
  TextEditingController contPassword = new TextEditingController();
  TextEditingController contCnfPass = new TextEditingController();

  var dialog;
  bool visible = true;
  bool visiblePass = true;
  bool checkboxterms = false;

  void seenPassword(){
    setState(() {
      visible = visible ? false : true;
    });
  }

  void seenConfPassword(){
    setState(() {
      visiblePass = visiblePass ? false : true;
    });
  }

  bool _validation(){
    if(contFirstName.text.toString() == ""){
      Toast.show("Please provide first name.",context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contLastName.text.toString() == ""){
      Toast.show("Please provide last name.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contEmail.text.toString() == ""){
      Toast.show("Please provide email address.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(!EmailValidator.validate(contEmail.text.toString())){
      Toast.show("Please provide valid email address.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contPhone.text.toString() == ""){
      Toast.show("Please provide phone number.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contPhone.text.toString().length < 10){
      Toast.show("Please provide valid phone number.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contPassword.text.toString() == ""){
      Toast.show("Please provide password.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contPassword.text.toString().length <8){
      Toast.show("The Password is too short: it must be at least 8 characters.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(contCnfPass.text.toString() != contPassword.text.toString()){
      Toast.show("Passwords does not matches.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else if(!checkboxterms){
      Toast.show("Please accept terms and conditions.",context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
      return false;
    }else{
      return true;
    }
  }

  void _clearPreferences(){
    Preferences.addUserId(0);
    Preferences.addToken("");
    Preferences.addName("");
    Preferences.addEmail("");
    Preferences.addPhone("");
  }

  fetchData(){
    var map =new Map<String,dynamic>();
    map['first_name'] = contFirstName.text.toString();
    map['last_name'] = contLastName.text.toString();
    map['email'] = contEmail.text.toString();
    map['phone_no'] = contPhone.text.toString();
    map['password'] = contCnfPass.text.toString();
    map['step_no'] = "1";
    map['device_type'] = 'ios';
    var user = new Map();
    user['user'] = map;
    return ApiService.register(user);
  }


  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15,5,15,5),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                alignment: Alignment.center,
                child: Text(
                  "Just a little more info and We'll Activate your Devices!",
                  style: TextStyle(color: Colors.black,fontFamily: "MontserratSemiBold",fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'First Name',
                          style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                        ),
                        SizedBox(height: 2.0),
                        Container(
                          height: 50.0,
                          child:TextField(
                            controller: contFirstName,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.black)
                              )
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Last Name',
                          style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                        ),
                        SizedBox(height: 2.0),
                        Container(
                          height: 50.0,
                          child: TextField(
                            controller: contLastName,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.black)
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email',
                    style: TextStyle(color:Colors.black,fontFamily: "MontserratSemiBold",fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    height: 50.0,
                    child: TextField(
                      controller: contEmail,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Phone',
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    maxLength: 10,
                    controller: contPhone,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular'),
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black)
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height:10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    maxLength: 50,
                    controller: contPassword,
                    keyboardType: TextInputType.text,
                    obscureText: visible ? false : true,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: visible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        onPressed: (){
                          seenPassword();
                        },
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black)
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Confirm Password',
                    style:TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    maxLength: 50,
                    controller: contCnfPass,
                    keyboardType: TextInputType.text,
                    obscureText: visiblePass ? false:true,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                    decoration: InputDecoration(
                      fillColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                      suffixIcon: IconButton(
                        icon: visiblePass ? Icon(Icons.visibility) :  Icon(Icons.visibility_off),
                        onPressed: (){
                          seenConfPassword();
                        },
                      ),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onChanged: (bool value) {
                      setState(() {
                        checkboxterms = checkboxterms ? false : true;
                      });
                    },
                    value: checkboxterms
                  ),
                  Container(
                    child: Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 14.0),
                          children: <TextSpan>[
                            TextSpan(text:'By creating an account,you agree to Folloh '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(color:Colors.blue,decoration: TextDecoration.underline,fontSize: 14.0),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch('https://www.ptlabs.tech/terms-of-service');
                                }
                            )
                          ]
                        )
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  height: 45.0,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(_validation()){
                        dialog.show();
                        fetchData().then((result){
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = FollohResponse.fromJson(jsonDecode(result));
                            if(response.status == 200 ){
                              _clearPreferences();
                              Preferences.addUserId(response.user.id);
                              Preferences.addToken(response.user.token);
                              Preferences.addName(response.user.firstName+","+response.user.lastName);
                              Preferences.addEmail(response.user.email);
                              Preferences.addPhone(contPhone.text.toString());
                              /*Preferences.isSignUp=true
                              Preferences.isPet=true*/
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
                  ),
                )
              ),
              SizedBox(height:10.0)
            ]
          )
        )
      )
    );
  }
}