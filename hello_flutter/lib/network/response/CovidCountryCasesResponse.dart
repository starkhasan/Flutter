// To parse this JSON data, do
//
//     final covidCountryCasesResponse = covidCountryCasesResponseFromJson(jsonString);

import 'dart:convert';

List<CovidCountryCasesResponse> covidCountryCasesResponseFromJson(String str) => List<CovidCountryCasesResponse>.from(json.decode(str).map((x) => CovidCountryCasesResponse.fromJson(x)));

String covidCountryCasesResponseToJson(List<CovidCountryCasesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CovidCountryCasesResponse {
    CovidCountryCasesResponse({
        this.country,
        this.countryCode,
        this.province,
        this.city,
        this.cityCode,
        this.lat,
        this.lon,
        this.confirmed,
        this.deaths,
        this.recovered,
        this.active,
        this.date,
    });

    Country country;
    String countryCode;
    String province;
    String city;
    String cityCode;
    String lat;
    String lon;
    int confirmed;
    int deaths;
    int recovered;
    int active;
    DateTime date;

    factory CovidCountryCasesResponse.fromJson(Map<String, dynamic> json) => CovidCountryCasesResponse(
        country: countryValues.map[json["Country"]],
        countryCode: json["CountryCode"],
        province: json["Province"],
        city: json["City"],
        cityCode: json["CityCode"],
        lat: json["Lat"],
        lon: json["Lon"],
        confirmed: json["Confirmed"],
        deaths: json["Deaths"],
        recovered: json["Recovered"],
        active: json["Active"],
        date: DateTime.parse(json["Date"]),
    );

    Map<String, dynamic> toJson() => {
        "Country": countryValues.reverse[country],
        "CountryCode": countryCode,
        "Province": province,
        "City": city,
        "CityCode": cityCode,
        "Lat": lat,
        "Lon": lon,
        "Confirmed": confirmed,
        "Deaths": deaths,
        "Recovered": recovered,
        "Active": active,
        "Date": date.toIso8601String(),
    };
}

enum Country { INDIA }

final countryValues = EnumValues({
    "India": Country.INDIA
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
