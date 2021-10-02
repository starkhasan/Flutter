// To parse this JSON data, do
//
//     final vaccinationResponse = vaccinationResponseFromJson(jsonString);

import 'dart:convert';

List<VaccinationResponse> vaccinationResponseFromJson(String str) =>
    List<VaccinationResponse>.from(json.decode(str).map((x) => VaccinationResponse.fromJson(x)));

String vaccinationResponseToJson(List<VaccinationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VaccinationResponse {
  VaccinationResponse(
    this.country,
    this.isoCode,
    this.data,
  );

  String country;
  String isoCode;
  List<Datum> data;

  VaccinationResponse.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        isoCode = json["iso_code"],
        data = List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));

  Map<String, dynamic> toJson() => {
        "country": country,
        "iso_code": isoCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
    this.date,
    this.totalVaccinations,
    this.peopleVaccinated,
    this.totalVaccinationsPerHundred,
    this.peopleVaccinatedPerHundred,
    this.dailyVaccinations,
    this.dailyVaccinationsPerMillion,
    this.peopleFullyVaccinated,
    this.peopleFullyVaccinatedPerHundred,
    this.dailyVaccinationsRaw,
    this.totalBoosters,
    this.totalBoostersPerHundred,
  );

  String date;
  int? totalVaccinations;
  int? peopleVaccinated;
  double? totalVaccinationsPerHundred;
  double? peopleVaccinatedPerHundred;
  int? dailyVaccinations;
  int? dailyVaccinationsPerMillion;
  int? peopleFullyVaccinated;
  double? peopleFullyVaccinatedPerHundred;
  int? dailyVaccinationsRaw;
  int? totalBoosters;
  double? totalBoostersPerHundred;

  Datum.fromJson(Map<String, dynamic> json)
      : date = json["date"],
        totalVaccinations = json["total_vaccinations"] == null
            ? null
            : json["total_vaccinations"],
        peopleVaccinated = json["people_vaccinated"] == null
            ? null
            : json["people_vaccinated"],
        totalVaccinationsPerHundred =
            json["total_vaccinations_per_hundred"] == null
                ? null
                : json["total_vaccinations_per_hundred"].toDouble(),
        peopleVaccinatedPerHundred =
            json["people_vaccinated_per_hundred"] == null
                ? null
                : json["people_vaccinated_per_hundred"].toDouble(),
        dailyVaccinations = json["daily_vaccinations"] == null
            ? null
            : json["daily_vaccinations"],
        dailyVaccinationsPerMillion =
            json["daily_vaccinations_per_million"] == null
                ? null
                : json["daily_vaccinations_per_million"],
        peopleFullyVaccinated = json["people_fully_vaccinated"] == null
            ? null
            : json["people_fully_vaccinated"],
        peopleFullyVaccinatedPerHundred =
            json["people_fully_vaccinated_per_hundred"] == null
                ? null
                : json["people_fully_vaccinated_per_hundred"].toDouble(),
        dailyVaccinationsRaw = json["daily_vaccinations_raw"] == null
            ? null
            : json["daily_vaccinations_raw"],
        totalBoosters =
            json["total_boosters"] == null ? null : json["total_boosters"],
        totalBoostersPerHundred = json["total_boosters_per_hundred"] == null
            ? null
            : json["total_boosters_per_hundred"].toDouble();

  Map<String, dynamic> toJson() => {
        "date": date,
        "total_vaccinations":
            totalVaccinations == null ? null : totalVaccinations,
        "people_vaccinated": peopleVaccinated == null ? null : peopleVaccinated,
        "total_vaccinations_per_hundred": totalVaccinationsPerHundred == null
            ? null
            : totalVaccinationsPerHundred,
        "people_vaccinated_per_hundred": peopleVaccinatedPerHundred == null
            ? null
            : peopleVaccinatedPerHundred,
        "daily_vaccinations":
            dailyVaccinations == null ? null : dailyVaccinations,
        "daily_vaccinations_per_million": dailyVaccinationsPerMillion == null
            ? null
            : dailyVaccinationsPerMillion,
        "people_fully_vaccinated":
            peopleFullyVaccinated == null ? null : peopleFullyVaccinated,
        "people_fully_vaccinated_per_hundred":
            peopleFullyVaccinatedPerHundred == null
                ? null
                : peopleFullyVaccinatedPerHundred,
        "daily_vaccinations_raw":
            dailyVaccinationsRaw == null ? null : dailyVaccinationsRaw,
        "total_boosters": totalBoosters == null ? null : totalBoosters,
        "total_boosters_per_hundred":
            totalBoostersPerHundred == null ? null : totalBoostersPerHundred,
      };
}
