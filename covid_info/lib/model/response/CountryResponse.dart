// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

List<CountryResponse> countryResponseFromJson(String str) => List<CountryResponse>.from(json.decode(str).map((x) => CountryResponse.fromJson(x)));

String countryResponseToJson(List<CountryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryResponse {
    CountryResponse({
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

    factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
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
