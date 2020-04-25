import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget{
  // Profile({Key key, @required this.textreceived}) : super(key: key);

  @override
  _MyProfilePage createState() => _MyProfilePage();
  
}

class _MyProfilePage extends State<Profile>{

  var dialog;
  bool _obscureText = true;
  bool _obscureText1 = true;
  String firstname = "";
  String lastname = "";
  String email = "";
  String phone = "";
  String password = "";
  int userId = 0;

  TextEditingController firstText = new TextEditingController();
  TextEditingController lastText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  TextEditingController confirmPassText = new TextEditingController();


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1(){
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  void initState(){
    Preferences.getName().then((onValue){
      setState(() {
        var fullname = onValue.split(",");
        firstname = fullname[0];
        firstText.text = firstname;
        lastname = fullname[1];
        lastText.text=lastname;
      });
    });
    Preferences.getEmail().then((onValue){
      setState(() {
        email = onValue;
      });
    });
    Preferences.getPhone().then((onValue){
      setState(() {
        phone = onValue;
      });
    });
    Preferences.getPassword().then((onValue){
      setState(() {
        password = onValue;
        passwordText.text=password;
        confirmPassText.text=password;
      });
    });
    Preferences.getUserId().then((onValue){
      setState(() {
        userId = onValue;
      });
    });
    super.initState();
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['user_id'] = userId;
    map['password'] = confirmPassText.text;
    map['first_name'] = firstText.text;
    map['last_name'] = lastText.text;
    var user = new Map();
    user['user']=map;
    return  ApiService.signin(user);
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'First Name',
                          style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                        ),
                        SizedBox(height: 2.0),
                        Container(
                          height: 50,
                          child: TextField(
                            controller: firstText,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                            decoration: InputDecoration(
                              hintText: 'First Name',
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
                  SizedBox(width: 10.0,),
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
                          height: 50,
                          child: TextField(
                            controller: lastText,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.black)
                              )
                            )
                          )
                        )
                      ]
                    )
                  )
                ]
              ),
              SizedBox(height: 10.0),        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email',
                    style:TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0,0),
                    height: 50,
                    child: TextField(
                      controller: TextEditingController(text: email),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      enabled: false,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(int.parse('#f0f0f0'.replaceAll('#', '0xff'))),
                        hintText: "Email",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Phone Number',
                    style:TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0,0),
                    height: 50,
                    child: TextField(
                      controller: TextEditingController(text: phone),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      enabled: false,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(int.parse('#f0f0f0'.replaceAll('#', '0xff'))),
                        hintText: "Phone Number",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    style:TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0,0),
                    height: 50,
                    child: TextField(
                      controller: passwordText,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          tooltip: _obscureText ? 'Visibility ON':'Visibility OFF',
                          icon: _obscureText ? Icon(Icons.visibility_off): Icon(Icons.visibility),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                        hintText: "Password",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Confirm Password',
                    style:TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0,0),
                    height: 50,
                    child: TextField(
                      controller: confirmPassText,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText1,
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular',fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: _obscureText1 ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          onPressed: (){
                            _toggle1();
                          },
                        ),
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      )
                    )
                  )
                ]
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onPressed: (){
                      dialog.show();
                      fetchData().then((result){
                        dialog.hide();
                        Toast.show('Working',context,duration: Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    )
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


