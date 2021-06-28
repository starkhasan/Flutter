import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:hello_flutter/network/response/CountriesResponse.dart';
import 'package:hello_flutter/network/response/CovidCountryCasesResponse.dart';

class CovidProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool _isCovidCaseFetching = false;
  bool get isFetchingCountry => _isFetching;
  bool get isFetchingCases => _isCovidCaseFetching;
  List<CountriesResponse> countryResponse = [];
  List<CovidCountryCasesResponse> covidCountryCaseResponse = [];

  Future<void> countryApi(String date) async {
    _isFetching = true;
    notifyListeners();
    var response = await Api.getCountries();
    if (response.statusCode == 200) {
      countryResponse = List<CountriesResponse>.from(json.decode(response.body).map((x) => CountriesResponse.fromJson(x)));
    }
    covidCountryCase(false,'india',date);
  }

  Future<void> covidCountryCase(bool isDirect, String countryName,String date) async {
    if (isDirect) {
      _isCovidCaseFetching = true;
      notifyListeners();
    }
    var response = await Api.getCountriesCases(countryName,date);
    if(response.statusCode == 200){
      covidCountryCaseResponse = List<CovidCountryCasesResponse>.from(json.decode(response.body).map((x) => CovidCountryCasesResponse.fromJson(x)));
    }
    if (isDirect) {
      _isCovidCaseFetching = false;
      notifyListeners();
    }else{
      _isFetching = false;
      notifyListeners();
    } 
  }
}
