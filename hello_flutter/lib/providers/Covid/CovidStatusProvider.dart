import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:hello_flutter/network/response/CovidCountryCasesResponse.dart';
import 'dart:convert';

class CovidStatusProvider extends ChangeNotifier {
  bool _callApi = true;
  bool _countryApi = false;
  int totalCases = 0;
  int totalRecovered = 0;
  int newCases = 0;
  int totalDeaths = 0;
  bool get apiCalling => _callApi;
  bool get apiCountry => _countryApi;
  List<CovidCountryCasesResponse> covidResponse = [];
  List<int> covidStatusResponse = [0,0,0,0];

  Future<void> covidStatus( String countryName,String date) async {
    _callApi = true;
    notifyListeners();
    try{
      var response = await Api.getCountriesCases(countryName,date);
      if(response.statusCode == 200){
        covidResponse = List<CovidCountryCasesResponse>.from(json.decode(response.body).map((x) => CovidCountryCasesResponse.fromJson(x)));
        var size = covidResponse.length;
        covidStatusResponse[0] = covidResponse[size-1].confirmed;
        covidStatusResponse[1] = covidResponse[size-1].recovered;
        covidStatusResponse[2] = covidResponse[size-1].active;
        covidStatusResponse[3] = covidResponse[size-1].deaths;
      }else{
        covidStatusResponse = [0,0,0,0];
      }
    }catch(e){
      covidStatusResponse = [0,0,0,0];
    }
    _callApi = false;
    notifyListeners(); 
  }
}
