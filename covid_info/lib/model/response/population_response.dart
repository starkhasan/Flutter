// To parse this JSON data, do
//
//     final populationResponse = populationResponseFromJson(jsonString);

import 'dart:convert';

PopulationResponse populationResponseFromJson(String str) => PopulationResponse.fromJson(json.decode(str));

String populationResponseToJson(PopulationResponse data) => json.encode(data.toJson());

class PopulationResponse {
    PopulationResponse({
        required this.ok,
        required this.body,
    });

    bool ok;
    Body body;

    factory PopulationResponse.fromJson(Map<String, dynamic> json) => PopulationResponse(
        ok: json["ok"],
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "body": body.toJson(),
    };
}

class Body {
    Body({
        required this.countryName,
        required this.population,
        required this.ranking,
        required this.worldShare,
    });

    String countryName;
    int population;
    int ranking;
    double worldShare;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        countryName: json["country_name"],
        population: json["population"],
        ranking: json["ranking"],
        worldShare: json["world_share"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "country_name": countryName,
        "population": population,
        "ranking": ranking,
        "world_share": worldShare,
    };
}
