import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/AddPetResponse.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class AddPets extends StatefulWidget {
  @override
  _AddPetsState createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> {

  bool batchVisible = false;
  String token = "";
  String petCount = '';
  String dropdownValue = "Dog";
  List<String> pets = ["Dog","Cat"];
  TextEditingController _contDevice = new TextEditingController();
  TextEditingController _contPetName = new TextEditingController();
  TextEditingController _contBreed = new TextEditingController();
  TextEditingController _contBirthDay = new TextEditingController();
  var dialog;

  void openCalendar(){
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        print('confirm $date');
        var dateList = date.toString().substring(0,10).split("-");
        var currentDate = "";
        for(var i=dateList.length-1;i>=0;i--){
          if(i == dateList.length-1){
            currentDate = currentDate + dateList[i];
          }else{
            currentDate = currentDate + "/" +dateList[i];
          }
        }
        _contBirthDay.text = currentDate;
      },
      currentTime: DateTime.now(), locale: LocaleType.en
    );
  }

  @override
  void initState(){
    Preferences.getToken().then((onValue){
      setState(() {
        token = onValue;
      });
    });
    super.initState();
  }

  bool validation(){
    if(_contDevice.text.toString() == ""){
      Toast.show("Please provide Device ID", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(_contDevice.text.toString().length<10){
      Toast.show("Please provide valid Device ID", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(_contPetName.text.toString() == ""){
      Toast.show("Please provide Pet Name", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else{
      return true;
    }
  }

  fetchData(){
    var map = new Map<String,dynamic>();
    map['device_id'] = _contDevice.text.toString();
    map['name'] = _contPetName.text.toString();
    map['animal_type'] = dropdownValue;
    map['breed'] = _contBreed.text.toString();
    map['birthday'] = _contBirthDay.text.toString();
    var user = Map();
    user['temp_pet'] = map;
    return ApiService.addPets(user);
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Add Pet Information'
        ),
        actions: <Widget>[
          Badge(
            showBadge: batchVisible ? true : false,
            position: BadgePosition.topRight(top: 3, right: 8),
            badgeContent: Text(
              petCount,
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              iconSize: 26.0,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                if(petCount!= ""){
                  Toast.show('Navigate',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                }else{
                  Toast.show('No Device Added',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                }
              },
            )
          )
        ]
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Device ID',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50.0,
                child: TextField(
                  controller: _contDevice,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'Enter Device ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  )
                )
              ),
              SizedBox(height: 15.0),
              Text(
                'Pet Name',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50.0,
                child: TextField(
                  controller: _contPetName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color:Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: 'Enter Pet Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'Pet Type',
                style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.fromLTRB(10.0,5.0,5.0,5.0),
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color:Colors.black,
                    width:0.5
                  )
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: pets
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                )
              ),
              SizedBox(height: 15.0),
              Text(
                'Breed of Pet',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50.0,
                child: TextField(
                  controller: _contBreed,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: "Enter Breed of Pet",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  )
                )
              ),
              SizedBox(height: 15.0),
              Text(
                'Birthday',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 5.0),
              InkWell(
                onTap:(){
                  openCalendar();
                },
                child: Container(
                  height: 50.0,
                  child: IgnorePointer(
                    child: TextField(
                      controller: _contBirthDay,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'BirthDay',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      )
                    )
                  )
                )
              ),
              SizedBox(height: 15.0),
              Container(
                margin: EdgeInsets.fromLTRB(30,0,30,0),
                child:SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(validation()){
                        dialog.show();
                        fetchData().then((result){
                          dialog.hide();
                          if(jsonDecode(result)['status'] == 200){
                            var response = AddPetResponse.fromJson(jsonDecode(result));
                            if(response.status == 200){
                              var tempPets = response.tempPetCount;
                              setState(() {
                                petCount = tempPets.toString();
                                batchVisible = true;
                              });
                            }else{
                              Toast.show(response.message,context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                            }
                          }else{
                            Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                          }
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Text(
                      'ADD PET',
                      style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    ),
                  ),
                )
              )
            ]
          )
        )
      )
    );
  }
}