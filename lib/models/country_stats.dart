// To parse this JSON data, do
//
//     final countryStats = countryStatsFromJson(jsonString);

import 'dart:convert';

class CountryStats {
  final String updated;
  final String country;
  final CountryInfo countryInfo;
  final String cases;
  final String todayCases;
  final String deaths;
  final String todayDeaths;
  final String recovered;
  final String active;
  final String critical;
  final String casesPerOneMillion;
  final String deathsPerOneMillion;
  final String tests;
  final String testsPerOneMillion;
  final String population;
  final String continent;
  final String activePerOneMillion;
  final String recoveredPerOneMillion;
  final String criticalPerOneMillion;

  CountryStats({
    this.updated,
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.continent,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
  });

  CountryStats copyWith({
    String updated,
    String country,
    CountryInfo countryInfo,
    String cases,
    String todayCases,
    String deaths,
    String todayDeaths,
    String recovered,
    String active,
    String critical,
    String casesPerOneMillion,
    String deathsPerOneMillion,
    String tests,
    String testsPerOneMillion,
    String population,
    String continent,
    String activePerOneMillion,
    String recoveredPerOneMillion,
    String criticalPerOneMillion,
  }) =>
      CountryStats(
        updated: updated ?? this.updated,
        country: country ?? this.country,
        countryInfo: countryInfo ?? this.countryInfo,
        cases: cases ?? this.cases,
        todayCases: todayCases ?? this.todayCases,
        deaths: deaths ?? this.deaths,
        todayDeaths: todayDeaths ?? this.todayDeaths,
        recovered: recovered ?? this.recovered,
        active: active ?? this.active,
        critical: critical ?? this.critical,
        casesPerOneMillion: casesPerOneMillion ?? this.casesPerOneMillion,
        deathsPerOneMillion: deathsPerOneMillion ?? this.deathsPerOneMillion,
        tests: tests ?? this.tests,
        testsPerOneMillion: testsPerOneMillion ?? this.testsPerOneMillion,
        population: population ?? this.population,
        continent: continent ?? this.continent,
        activePerOneMillion: activePerOneMillion ?? this.activePerOneMillion,
        recoveredPerOneMillion:
            recoveredPerOneMillion ?? this.recoveredPerOneMillion,
        criticalPerOneMillion:
            criticalPerOneMillion ?? this.criticalPerOneMillion,
      );

  factory CountryStats.fromRawJson(String str) =>
      CountryStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryStats.fromJson(Map<String, dynamic> json) => CountryStats(
        updated: json["updated"].toString(),
        country: json["country"].toString(),
        countryInfo: CountryInfo.fromJson(json["countryInfo"]),
        cases: json["cases"].toString(),
        todayCases: json["todayCases"].toString(),
        deaths: json["deaths"].toString(),
        todayDeaths: json["todayDeaths"].toString(),
        recovered: json["recovered"].toString(),
        active: json["active"].toString(),
        critical: json["critical"].toString(),
        casesPerOneMillion: json["casesPerOneMillion"].toString(),
        deathsPerOneMillion: json["deathsPerOneMillion"].toString(),
        tests: json["tests"].toString(),
        testsPerOneMillion: json["testsPerOneMillion"].toString(),
        population: json["population"].toString(),
        continent: json["continent"].toString(),
        activePerOneMillion: json["activePerOneMillion"].toString(),
        recoveredPerOneMillion: json["recoveredPerOneMillion"].toString(),
        criticalPerOneMillion: json["criticalPerOneMillion"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "country": country,
        "countryInfo": countryInfo.toJson(),
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
        "tests": tests,
        "testsPerOneMillion": testsPerOneMillion,
        "population": population,
        "continent": continent,
        "activePerOneMillion": activePerOneMillion,
        "recoveredPerOneMillion": recoveredPerOneMillion,
        "criticalPerOneMillion": criticalPerOneMillion,
      };
}

class CountryInfo {
  final int id;
  final String iso2;
  final String iso3;
  final String lat;
  final String long;
  final String flag;

  CountryInfo({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  CountryInfo copyWith({
    int id,
    String iso2,
    String iso3,
    String lat,
    String long,
    String flag,
  }) =>
      CountryInfo(
        id: id ?? this.id,
        iso2: iso2 ?? this.iso2,
        iso3: iso3 ?? this.iso3,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        flag: flag ?? this.flag,
      );

  factory CountryInfo.fromRawJson(String str) =>
      CountryInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        id: json["_id"],
        iso2: json["iso2"].toString(),
        iso3: json["iso3"].toString(),
        lat: json["lat"].toString(),
        long: json["long"].toString(),
        flag: json["flag"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "iso2": iso2,
        "iso3": iso3,
        "lat": lat,
        "long": long,
        "flag": flag,
      };
}
