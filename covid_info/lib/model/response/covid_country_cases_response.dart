// To parse this JSON data, do
//
//     final covidCountryCasesResponse = covidCountryCasesResponseFromJson(jsonString);

import 'dart:convert';

CovidCountryCasesResponse covidCountryCasesResponseFromJson(String str) => CovidCountryCasesResponse.fromJson(json.decode(str));

String covidCountryCasesResponseToJson(CovidCountryCasesResponse data) => json.encode(data.toJson());

class CovidCountryCasesResponse {
    CovidCountryCasesResponse({
        required this.country,
        required this.cases,
        required this.todayCases,
        required this.deaths,
        required this.todayDeaths,
        required this.recovered,
        required this.active,
        required this.critical,
        required this.casesPerOneMillion,
        required this.deathsPerOneMillion,
        required this.totalTests,
        required this.testsPerOneMillion,
    });

    String country;
    int cases;
    int todayCases;
    int deaths;
    int todayDeaths;
    int recovered;
    int active;
    int critical;
    int casesPerOneMillion;
    int deathsPerOneMillion;
    int totalTests;
    int testsPerOneMillion;

    factory CovidCountryCasesResponse.fromJson(Map<String, dynamic> json) => CovidCountryCasesResponse(
        country: json["country"],
        cases: json["cases"]??0,
        todayCases: json["todayCases"]??0,
        deaths: json["deaths"]??0,
        todayDeaths: json["todayDeaths"]??0,
        recovered: json["recovered"]??0,
        active: json["active"]??0,
        critical: json["critical"]??0,
        casesPerOneMillion: json["casesPerOneMillion"]??0,
        deathsPerOneMillion: json["deathsPerOneMillion"]??0,
        totalTests: json["totalTests"]??0,
        testsPerOneMillion: json["testsPerOneMillion"]??0,
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
        "totalTests": totalTests,
        "testsPerOneMillion": testsPerOneMillion,
    };
}
