// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

List<CountryResponse> countryResponseFromJson(String str) => List<CountryResponse>.from(json.decode(str).map((x) => CountryResponse.fromJson(x)));

String countryResponseToJson(List<CountryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryResponse {
    CountryResponse({
        this.country,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion,
        this.totalTests,
        this.testsPerOneMillion,
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
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"] == null ? null : json["recovered"],
        active: json["active"] == null ? null : json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"],
        deathsPerOneMillion: json["deathsPerOneMillion"],
        totalTests: json["totalTests"],
        testsPerOneMillion: json["testsPerOneMillion"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered == null ? null : recovered,
        "active": active == null ? null : active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
        "totalTests": totalTests,
        "testsPerOneMillion": testsPerOneMillion,
    };
}
