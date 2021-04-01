import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/network/response/GlobalSummaryResponse.dart';

class CovidScreen extends StatefulWidget {
  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  Widget appBarTitle = Text('COVID-19 Alert');
  Icon actionIcon = Icon(Icons.search,color: Colors.white);
  List<dynamic> summaryResponse = [];
  List<dynamic> allResponse = [];
  var _textSearch = TextEditingController();
  var response;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _apiGetGlobalSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: appBarTitle,
          actions: [
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search){
                    actionIcon = Icon(Icons.close);
                    appBarTitle = TextField(
                      controller: _textSearch,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration.collapsed(
                        hintText: "Search Countries...",
                        hintStyle: TextStyle(color: Colors.white60)
                      ),
                      onChanged: (value){
                        if(value != "")
                          _searchCountries(value);
                        else{
                          setState(() {
                            summaryResponse.addAll(allResponse);
                          });
                        }
                      },
                      onSubmitted: (value) => print(value),
                    );
                  }else {
                    actionIcon = Icon(Icons.search);
                    appBarTitle = Text("COVID-19 Alert");
                  }
                });
              },
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Global Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: ''
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.language,color: Colors.black,size: 20)
                              ],
                            ),
                            Text(
                              response == null
                                ? '----:--:--'
                                : response.global.date.toString().substring(0,10) 
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.newConfirmed.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                Text('New Confirmed')
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.newDeaths.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                                Text('New Deaths')
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.newRecovered.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                                Text('New Recovered')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.totalConfirmed.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                Text('Total Confirmed')
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.totalDeaths.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                                Text('Total Deaths')
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  response == null
                                    ? '--'
                                    : response.global.totalRecovered.toString(),
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                                ),
                                Text('Total Recovered')
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1),
                _getListView()
              ],
            ),
          )
        )
      );
  }

  Widget _getListView(){
    return summaryResponse.length > 0
      ? ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: summaryResponse.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: () => print('Cases'),
            child: Card(
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              summaryResponse[index].country,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: ''
                              ),
                            ),
                            SizedBox(width: 5),
                            Image.network('https://www.countryflags.io/${summaryResponse[index].countryCode}/shiny/64.png',height: 20,width: 20)
                          ],
                        ),
                        Text(summaryResponse[index].date.toString().substring(0,10))
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              summaryResponse[index].totalConfirmed.toString(),
                              style: TextStyle(
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Text('Total Confirmed')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              summaryResponse[index].totalDeaths.toString(),
                              style: TextStyle(
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              )
                            ),
                            Text('Total Deaths')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              summaryResponse[index].totalRecovered.toString(),
                              style: TextStyle(
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              )
                            ),
                            Text('Total Recovered')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    : Center(
      child: Text(
        'Records Not Available',
        style: TextStyle(color: Colors.black,fontFamily: '',fontWeight: FontWeight.bold,fontSize: 16)
      ),
    );
  }

  _searchCountries(var result){
    summaryResponse.clear();
    for(var i=0;i<allResponse.length;i++){
      if(allResponse[i].country.toLowerCase().contains(result.toLowerCase())){
        summaryResponse.add(allResponse[i]);
      }
    }
    setState(() {});
  }

  _apiGetGlobalSummary() {
    fetchGlobalSummary().then((result) {
      try {
        setState(() {
          response = GlobalSummaryResponse.fromJson(json.decode(result));
          summaryResponse.addAll(response.countries);
          allResponse.addAll(response.countries);
        });
      } catch (e) {
        _showToast(result);
      }
    });
  }

  fetchGlobalSummary() {
    return Api.globalSummary();
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
