import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/PetsResponse.dart';
import 'package:flutterapp/ui/MyPetDetailsActivity.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:toast/toast.dart';

class Pets extends StatefulWidget {
  @override
  _PetsState createState() => _PetsState();
}
class _PetsState extends State<Pets> {

  var dialog;
  List<Pet> petResponse =[];
  var amount = 9.95;
  @override
  void initState(){
    fetchData().then((result){
      if(jsonDecode(result)['status'] == 200 && jsonDecode(result)['message'] != "No pets..please add pets details"){
        var response = PetsResponse.fromJson(jsonDecode(result));
        if(response.status == 200 ){
          setState(() {
            petResponse = response.pets;
          });
        }else{
          Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
        }
      }else{
        Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      }
    });
    super.initState();
  }

  fetchData(){
    return ApiService.getPets();
  }

  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Pet List'
        ),
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff")))
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "The Charge of Adding per pet is \$$amount/month",
                    style: TextStyle(color: Color(int.parse("#144473".replaceAll("#", "0xff"))),fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                  )
                ]
              )
            ),
            SizedBox(height: 10.0),
            Expanded( 
              child: ListView.builder(
                itemCount: petResponse.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      dense: false,
                      isThreeLine: true,
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text(
                              'Device ID',
                              style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              petResponse[index].deviceId,
                              style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      subtitle: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height:10.0),
                            Text(
                              'Pet Name',
                              style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              petResponse[index].name,
                              style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            ),
                            SizedBox(height: 2.0),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          String _petsDetails="";
                          _petsDetails = petResponse[index].deviceId;
                          _petsDetails = _petsDetails +"/"+petResponse[index].name;
                          _petsDetails = _petsDetails +"/"+petResponse[index].animalType;
                          if(petResponse[index].breed == null || petResponse[index].breed == ""){
                            _petsDetails = _petsDetails +"/"+" ";
                          }else{
                            _petsDetails = _petsDetails +"/"+petResponse[index].breed;
                          }
                          if(petResponse[index].birthday == null || petResponse[index].birthday == ""){
                            _petsDetails = _petsDetails +"/"+" ";
                          }else{
                            _petsDetails = _petsDetails +"/"+petResponse[index].birthday;
                          }
                          _petsDetails = _petsDetails+"/"+petResponse[index].id.toString();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPetDetailsActivity(text:_petsDetails)));
                        },
                      )
                    ),
                  );
                }
              )
            )
          ]
        )
      )
    );
  }
}