// To parse this JSON data, do
//
//     final countriesResponse = countriesResponseFromJson(jsonString);

import 'dart:convert';

List<CountriesResponse> countriesResponseFromJson(String str) => List<CountriesResponse>.from(json.decode(str).map((x) => CountriesResponse.fromJson(x)));

String countriesResponseToJson(List<CountriesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountriesResponse {
    CountriesResponse({
        this.country,
        this.slug,
        this.iso2,
    });

    String country;
    String slug;
    String iso2;

    factory CountriesResponse.fromJson(Map<String, dynamic> json) => CountriesResponse(
        country: json["Country"],
        slug: json["Slug"],
        iso2: json["ISO2"],
    );

    Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
    };
}
