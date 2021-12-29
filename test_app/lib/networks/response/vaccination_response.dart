class VaccinationResponse {
  String country;
  String isoCode;
  List<Datum> data;

  VaccinationResponse.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        isoCode = json["iso_code"],
        data = List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
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
        totalVaccinations = json["total_vaccinations"],
        peopleVaccinated = json["people_vaccinated"],
        totalVaccinationsPerHundred = json["total_vaccinations_per_hundred"],
        peopleVaccinatedPerHundred = json["people_vaccinated_per_hundred"],
        dailyVaccinations = json["daily_vaccinations"],
        dailyVaccinationsPerMillion = json["daily_vaccinations_per_million"],
        peopleFullyVaccinated = json["people_fully_vaccinated"],
        peopleFullyVaccinatedPerHundred =
            json["people_fully_vaccinated_per_hundred"],
        dailyVaccinationsRaw = json["daily_vaccinations_raw"],
        totalBoosters = json["total_boosters"],
        totalBoostersPerHundred = json["total_boosters_per_hundred"];
}
