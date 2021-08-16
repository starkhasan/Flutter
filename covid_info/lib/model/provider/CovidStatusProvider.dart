import 'package:flutter/cupertino.dart';
import 'package:covid_info/model/Api.dart';
import 'package:covid_info/model/response/CountryResponse.dart';
import 'package:covid_info/model/response/CovidCountryCasesResponse.dart';
import 'dart:convert';
import 'package:covid_info/model/response/PopulationResponse.dart';
import 'package:firebase_database/firebase_database.dart';

class CovidStatusProvider extends ChangeNotifier {
  bool _callApi = false;
  bool _countryApi = false;
  bool _vaccineApi = false;
  bool get apiCalling => _callApi;
  bool get apiCountry => _countryApi;
  bool get apiVaccine => _vaccineApi;

  bool countrySearchTopVisible = false;

  topVisiblility() {
    countrySearchTopVisible = countrySearchTopVisible ? false : true;
    notifyListeners();
  }

  String vcnResponse = '';
  int sites = 0;
  int sitesGovernment = 0;
  int sitesPrivate = 0;
  String stateVaccineUrl = '';
  late CovidCountryCasesResponse covidResponse;
  late PopulationResponse populationResponse;
  List<int> covidStatusResponse = [0, 0, 0, 0, 0, 0, 0];
  List<CountryResponse> countryResponse = [];
  List<CountryResponse> originalCountryResponse = [];
  List<int> vaccineResponse = [0, 0, 0, 0];
  List<String> vaccineName = [];
  var firebaseDatabase =
      FirebaseDatabase.instance.reference().child('covid_info');

  Future<void> covidStatus(bool isIndicator) async {
    _callApi = isIndicator;
    notifyListeners();
    // try {
    //   var response = await Api.getCountriesCases();
    //   if (response.statusCode == 200) {
    //     covidResponse =
    //         CovidCountryCasesResponse.fromJson(json.decode(response.body));
    //     covidStatusResponse[1] = covidResponse.cases;
    //     covidStatusResponse[2] = covidResponse.recovered;
    //     covidStatusResponse[3] = covidResponse.active;
    //     covidStatusResponse[4] = covidResponse.deaths;
    //     covidStatusResponse[5] = covidResponse.critical;
    //     covidStatusResponse[6] = covidResponse.todayCases;
    //   } else {
    //     covidStatusResponse = [0, 0, 0, 0, 0, 0, 0];
    //   }
    // } catch (e) {
    //   covidStatusResponse = [0, 0, 0, 0, 0, 0, 0];
    // }
    await population();
    _callApi = false;
    notifyListeners();
  }

  Future<void> countryCases(bool isIndicator) async {
    _countryApi = isIndicator;
    notifyListeners();
    try {
      var response = await Api.countryCovidList();

      if (response.statusCode == 200) {
        countryResponse.clear();
        originalCountryResponse.clear();
        var temp = List<CountryResponse>.from(
            json.decode(response.body).map((x) => CountryResponse.fromJson(x)));
        countryResponse.addAll(temp);
        originalCountryResponse.addAll(temp);
        print(countryResponse.length);
      } else {
        countryResponse = [];
      }
    } catch (e) {
      countryResponse = [];
    }
    _countryApi = false;
    notifyListeners();
  }

  searchCountry(String input) {
    countryResponse.clear();
    if (input.isEmpty) {
      countryResponse.addAll(originalCountryResponse);
    } else {
      for (var i = 0; i < originalCountryResponse.length; i++) {
        if (originalCountryResponse[i]
            .country
            .toLowerCase()
            .contains(input.toLowerCase())) {
          countryResponse.add(originalCountryResponse[i]);
        }
      }
    }
    notifyListeners();
  }

  vaccineList() async {
    await firebaseDatabase.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        vaccineResponse[0] = snapshot.value['registration'];
        sites = snapshot.value['sites'];
        sitesGovernment = snapshot.value['government'];
        sitesPrivate = snapshot.value['private'];
        vaccineName = snapshot.value['vaccine'].split('-');
        stateVaccineUrl = snapshot.value['stateVaccineUrl'];
        var strAr = snapshot.value['vaccination'].split(' ');
        vaccineResponse[1] = int.parse(strAr[0]);
        vaccineResponse[2] = int.parse(strAr[1]);
        vaccineResponse[3] = int.parse(strAr[2]);
      }
    });
  }

  population() async {
    await firebaseDatabase.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        covidStatusResponse[0] = snapshot.value['population'];
        var coronaCase = snapshot.value['corona'].split(' ');
        covidStatusResponse[1] = int.parse(coronaCase[0]);
        covidStatusResponse[2] = int.parse(coronaCase[1]);
        covidStatusResponse[3] = int.parse(coronaCase[2]);
        covidStatusResponse[4] = int.parse(coronaCase[3]);
        covidStatusResponse[5] = int.parse(coronaCase[4]);
        covidStatusResponse[6] = int.parse(coronaCase[5]);
      } else {
        covidStatusResponse = [0, 0, 0, 0, 0, 0, 0];
      }
    });
  }

  Future<void> vaccination(bool isIndicator) async {
    _vaccineApi = isIndicator;
    notifyListeners();
    // try {
    //   if (vcnResponse.isEmpty)
    //     vcnResponse = await http.read(Uri.parse(
    //         'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/India.csv'));
    //   vcnResponse = vcnResponse.split(',').reversed.join(',');
    //   var strAr = vcnResponse.split(',');
    //   vaccineResponse[1] = int.parse(strAr[2]);
    //   vaccineResponse[2] = int.parse(strAr[1]);
    //   vaccineResponse[3] = int.parse(strAr[0]);
    // } catch (e) {
    //   vaccineResponse = [0, 0, 0, 0];
    // }
    await vaccineList();
    _vaccineApi = false;
    notifyListeners();
  }
}
