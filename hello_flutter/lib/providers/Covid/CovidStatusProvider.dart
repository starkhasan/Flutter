import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:hello_flutter/network/response/CountryResponse.dart';
import 'package:hello_flutter/network/response/CovidCountryCasesResponse.dart';
import 'dart:convert';

class CovidStatusProvider extends ChangeNotifier {
  bool _callApi = false;
  bool _countryApi = false;
  bool get apiCalling => _callApi;
  bool get apiCountry => _countryApi;
  List<CovidCountryCasesResponse> covidResponse = [];
  List<int> covidStatusResponse = [0,0,0,0];
  List<CountryResponse> countryResponse = [];
  List<CountryResponse> originalCountryResponse = [];

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


  Future<void> countryCases() async{
    _countryApi = true;
    notifyListeners();
    try{
      var response = await Api.countryCovidList();
      if(response.statusCode == 200){
        var temp = List<CountryResponse>.from(json.decode(response.body).map((x) => CountryResponse.fromJson(x)));
        countryResponse.addAll(temp);
        originalCountryResponse.addAll(temp);
        print(countryResponse.length);
      }else{
        countryResponse = [];
      }
    }catch(e){
      countryResponse = [];
    }
    _countryApi = false;
    notifyListeners();
  }

  searchCountry(String input){
    countryResponse.clear();
    if(input.isEmpty){
      countryResponse.addAll(originalCountryResponse);
    }else{
      for(var i=0;i<originalCountryResponse.length;i++){
        if(originalCountryResponse[i].country.toLowerCase().contains(input.toLowerCase())){
          countryResponse.add(originalCountryResponse[i]);
        }
      }
    }
    notifyListeners();
  }
}
