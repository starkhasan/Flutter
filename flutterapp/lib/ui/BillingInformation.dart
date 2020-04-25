import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/FollohResponse.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/AddPets.dart';
import 'package:flutterapp/ui/SearchAddress.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class BillingInformation extends StatefulWidget {
  @override
  _BillingInformationState createState() => _BillingInformationState();
  
}
class _BillingInformationState extends State<BillingInformation> {

  var dialog;
  int userId = 0;
  String token = "";

  TextEditingController _controller = new TextEditingController();
  TextEditingController contName = new TextEditingController();
  TextEditingController contCity = new TextEditingController();
  TextEditingController contState = new TextEditingController();
  TextEditingController contZip = new TextEditingController();

  bool _validation(){
    if(contName.text.toString() == ""){
      Toast.show("Please provide name", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contCity.text.toString() == ""){
      Toast.show("Please provide city name", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contState.text.toString() == ""){
      Toast.show("Please provide state name", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contZip.text.toString() == ""){
      Toast.show("Please provide zip code", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else{
      return true;
    }
  }

  @override
  void initState(){
    Preferences.getName().then((onValue){
      setState(() {
        contName.text = onValue.replaceAll(",", " ") ?? "";
      });
    });
    Preferences.getUserId().then((onValue){
      setState(() {
        userId = onValue;
        print(userId.toString());
      });
    });
    Preferences.getToken().then((result){
      setState(() {
        token = result;
        print(token.toString());
      });
    });
    super.initState();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => SearchAddress()));
    var address = result.toString().split("/");
    setState(() {
      if(address[0]!=""){
        _controller.text = address[0];
      }else{
        _controller.text = "";
      }
      if(address[1]!=""){
        contCity.text = address[1];
      }else{
        contCity.text = "";
      }
      if(address[2]!=""){
        contState.text = address[2];
      }else{
        contState.text = "";
      }

      if(address[3]!=""){
        contZip.text = address[3];
      }else{
        contZip.text = "";
      }
    });
  }

  fetchData(){
    var info = Map<String,dynamic>();
    var map = Map<String,dynamic>();
    map["user_id"] = userId;
    map["step_no"] = 2;
    info["city"] = contCity.text.toString();
    info["name"] = contName.text.toString();
    info["street1"] = _controller.text.toString();
    info["state"] = contState.text.toString();
    info["zipcode"] = contZip.text.toString();
    map["billing_address"] = info;
    var user = Map();
    user['user'] = map;
    return ApiService.addUserProfile(user);
  }

  @override
  Widget build(BuildContext context) {
    dialog= CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle : true,
        title: Text('Billing Information'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height: 2.0),
              Container(
                height: 50.0,
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  textInputAction: TextInputAction.done,
                  controller: contName,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black)
                    )
                  )
                )
              ),
              SizedBox(height: 10.0),
              Text(
                'Home Address',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 2.0),
              GestureDetector(
                onTap: () {
                  _navigateAndDisplaySelection(context);
                },
                child: Container(
                  height: 50.0,
                  color: Colors.white,
                  child: IgnorePointer(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Home Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black)
                        )
                      )
                    )
                  )
                )
              ),
              SizedBox(height: 10.0),
              Text(
                'City',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 2.0),
              Container(
                height: 50.0,
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  controller: contCity,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black)
                    )
                  )
                )
              ),
              SizedBox(height: 10.0),
              Text(
                'State',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height:5.0),
              Container(
                height: 50.0,
                child:TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  controller: contState,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black)
                    )
                  )
                )
              ),
              SizedBox(height: 10.0),
              Text(
                'Zip Code',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height: 2.0),
              Container(
                height: 50.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: contZip,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'Zip Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black)
                    )
                  )
                )
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30,0),
                child: SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onPressed: (){
                      if(_validation()){
                        dialog.show();
                        fetchData().then((result){
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = FollohResponse.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPets()));
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
                      'NEXT',
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