import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:hello_flutter/network/response/CountryResponse.dart';
import 'package:hello_flutter/network/response/CovidCountryCasesResponse.dart';
import 'dart:convert';

import 'package:hello_flutter/network/response/PopulationResponse.dart';

class CovidStatusProvider extends ChangeNotifier {
  bool _callApi = false;
  bool _countryApi = false;
  bool get apiCalling => _callApi;
  bool get apiCountry => _countryApi;

  CovidCountryCasesResponse covidResponse;
  PopulationResponse populationResponse;
  List<int> covidStatusResponse = [0,0,0,0,0,0,0];
  List<CountryResponse> countryResponse = [];
  List<CountryResponse> originalCountryResponse = [];

  Future<void> covidStatus() async {
    _callApi = true;
    notifyListeners();
    try{
      var response = await Api.getCountriesCases();
      if(response.statusCode == 200){
        covidResponse = CovidCountryCasesResponse.fromJson(json.decode(response.body));
        covidStatusResponse[1] = covidResponse.cases;
        covidStatusResponse[2] = covidResponse.recovered;
        covidStatusResponse[3] = covidResponse.active;
        covidStatusResponse[4] = covidResponse.deaths;
        covidStatusResponse[5] = covidResponse.critical;
        covidStatusResponse[6] = covidResponse.todayCases;
      }else{
        covidStatusResponse = [0,0,0,0,0,0,0];
      }
    }catch(e){
      covidStatusResponse = [0,0,0,0,0,0,0];
    }
    await population();
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


  Future<void> population() async{
    try{
      var response = await Api.worldPopulation('India');
      if(response.statusCode == 200){
        populationResponse = PopulationResponse.fromJson(json.decode(response.body));
        covidStatusResponse[0] = populationResponse.body.population;
      }else{
        covidStatusResponse[0] = 0;
      }
    }catch(e){
      covidStatusResponse[0] = 0;
    }
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