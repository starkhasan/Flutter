import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/OtpResend.dart';
import 'package:flutterapp/ui/Pets.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:toast/toast.dart';

class MyPetDetailsActivity extends StatefulWidget {


  final String text;

  // receive data from the FirstScreen as a parameter
  MyPetDetailsActivity({Key key, this.text}) : super(key: key);
  @override
  _MyPetDetailsActivityState createState() =>  _MyPetDetailsActivityState();
}

class _MyPetDetailsActivityState extends State<MyPetDetailsActivity> {

  
  String petId='';
  bool batchVisible = false;
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
    map['id'] = petId;
    map['device_id'] = _contDevice.text.toString();
    map['name'] = _contPetName.text.toString();
    map['animal_type'] = dropdownValue;
    map['breed'] = _contBreed.text.toString();
    map['birthday'] = _contBirthDay.text.toString();
    var pet = Map();
    pet['pet'] = map;
    return ApiService.petUpdate(pet,petId);
  }

  @override
  void initState(){
    var petDetails = widget.text.split("/");
    setState(() {
      _contDevice.text = petDetails[0];
      _contPetName.text = petDetails[1];
      dropdownValue = petDetails[2];
      _contBreed.text = petDetails[3];
      _contBirthDay.text = petDetails[4];
      petId = petDetails[5];
    });
    super.initState();
  }

  Future<bool> _backPressed(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pets()));
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pets()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
          centerTitle: true,
          title: Text(
            'Add Pet Information'
          )
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
                              var response = OtpResend.fromJson(jsonDecode(result));
                              if(response.status == 200){
                                Toast.show(response.message,context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pets()));
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
                        'UPDATE',
                        style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                      ),
                    ),
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}