import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SearchAddress extends StatefulWidget {
  @override
  _SearchAddressState createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {

  List<String> addressResponse = [];

  void getLocationResult(String input) async{
    final String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String result = "$url?input=$input&key=***************************************&components=country:usa";
    var response = await Dio().get(result);
    List<String> searchResponse = [];
    for(var i=0;i<response.data['predictions'].length;i++){
      searchResponse.add(response.data['predictions'][i]['description']);
    }
    setState(() {
      addressResponse = searchResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        title: Text('Search Address'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratRegular'),
              decoration: InputDecoration(
                hintText: 'Search Your Address Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.black)
                )
              ),
              onChanged: (text){
                getLocationResult(text);
              },
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: addressResponse.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      addressResponse[index],
                      style: TextStyle(color: Colors.black,fontSize: 16.0,fontFamily: 'MontserratSemiBold')
                    ),
                    onTap: () async{
                      String _address="";
                      _address = addressResponse[index];
                      List<Placemark> placemark = await Geolocator().placemarkFromAddress(addressResponse[index]);
                      _address = _address +"/"+ placemark[0].locality;
                      _address = _address +"/"+ placemark[0].administrativeArea;
                      _address = _address +"/"+ placemark[0].postalCode;
                      Navigator.pop(context,_address);
                    }
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
