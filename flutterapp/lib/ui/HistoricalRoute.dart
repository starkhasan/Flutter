
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/GetAllLocation.dart';
import 'package:flutterapp/ui/PlayBack.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class HistoricalRoute extends StatefulWidget {

  @override
  _HistoricalRouteState createState() => _HistoricalRouteState();

}

class _HistoricalRouteState extends State<HistoricalRoute> {

  TextEditingController contStartDate = new TextEditingController();
  TextEditingController contEndDate = new TextEditingController();

  List<String> deviceID = [];
  String dropdownValue;
  var dialog;
  var startDateTime,endDateTime;
  List<DeviceDetail> devicedetails = [];

  @override
  void initState() {
    Preferences.getDeviceID().then((result){
      setState(() {
        deviceID = result;
      });
    });
    super.initState();
  }

  void openCalendar(String title){
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime.now(),
      theme: DatePickerTheme(
        itemStyle: TextStyle(color: Colors.black,fontSize: 18.0),
        doneStyle: TextStyle(color: Colors.blue,fontSize: 20.0),
        cancelStyle: TextStyle(color: Colors.red,fontSize: 20.0)
      ),
      currentTime: DateTime.now(), locale: LocaleType.en,
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        print('confirm $date');
        var temptime = date.toString().substring(0,10).replaceAll("-","")+date.toString().substring(11,16).replaceAll(":", "");
        var time = date.toString().substring(11,16);
        var dateList = date.toString().substring(0,10).split("-");
        var currentDate = "";
        for(var i=dateList.length-1;i>=0;i--){
          if(i == dateList.length-1){
            currentDate = currentDate + dateList[i];
          }else{
            currentDate = currentDate + "/" +dateList[i];
          }
        }
        if(title == 'startdate'){
          contStartDate.text = currentDate+" "+time;
          startDateTime = int.parse(temptime);
        }else{
          contEndDate.text = currentDate+" "+time;
          endDateTime = int.parse(temptime);
        }
      }
    );
  }

  bool validation(){
    if(contStartDate.text.toString() == ""){
      Toast.show("Please provide Start Date", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(contEndDate.text.toString().length<10){
      Toast.show("Please provide End Date", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }else if(startDateTime>endDateTime){
      Toast.show('Please provide valid date and time.', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  fetchData(){
    var map = Map<String,dynamic>();
    map['start_date'] = contStartDate.text;
    map['stop_date'] = contEndDate.text;
    map['device_id'] = dropdownValue;
    return ApiService.getAllLocation(map);
  }


  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text('Historical Route')
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Device',
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
                  items: deviceID
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
                'Start Date',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 5.0),
              InkWell(
                onTap:(){
                  openCalendar('startdate');
                },
                child: Container(
                  height: 50.0,
                  child: IgnorePointer(
                    child: TextField(
                      controller: contStartDate,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Enter Start Date / Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      )
                    )
                  )
                )
              ),
              SizedBox(height: 15.0),
              Text(
                'End Date',
                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
              ),
              SizedBox(height: 5.0),
              InkWell(
                onTap:(){
                  openCalendar('enddate');
                },
                child: Container(
                  height: 50.0,
                  child: IgnorePointer(
                    child: TextField(
                      controller: contEndDate,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Enter End Date / Time',
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
                          devicedetails.clear();
                          if(jsonDecode(result)['status'] == 200){
                            var response = GetAllLocation.fromJson(json.decode(result));
                            if(response.status == 200){
                              devicedetails = response.deviceDetails;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayBack(list:devicedetails)));
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
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                    ),
                  ),
                )
              )
            ]
          )
        ),
      ),
    );
  }
}