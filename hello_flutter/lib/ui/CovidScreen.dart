import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/network/response/GlobalSummaryResponse.dart';

class CovidScreen extends StatefulWidget {
  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {

  List<dynamic> summaryResponse = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _apiGetGlobalSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loadingText: 'Loading...',
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('COVID-19 Alert', style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Global Data'),
                _getListView()
              ],
            ),
          )
        )
      )
    );
  }

  Widget _getListView(){
    return ListView.builder(
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
    );
  }

  _apiGetGlobalSummary() {
    showProgressDialog();
    fetchGlobalSummary().then((result) {
      dismissProgressDialog();
      try {
        var response = GlobalSummaryResponse.fromJson(json.decode(result));
        setState(() {
          summaryResponse = response.countries;
        });
        _showToast('Ok');
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
