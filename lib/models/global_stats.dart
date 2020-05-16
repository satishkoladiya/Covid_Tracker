// To parse this JSON data, do
//
//     final globalStats = globalStatsFromJson(jsonString);

import 'dart:convert';

class GlobalStats {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final double deathsPerOneMillion;
  final int tests;
  final double testsPerOneMillion;
  final int population;
  final double activePerOneMillion;
  final double recoveredPerOneMillion;
  final double criticalPerOneMillion;
  final int affectedCountries;

  GlobalStats({
    this.updated,
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
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
    this.affectedCountries,
  });

  GlobalStats copyWith({
    int updated,
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int recovered,
    int active,
    int critical,
    int casesPerOneMillion,
    double deathsPerOneMillion,
    int tests,
    double testsPerOneMillion,
    int population,
    double activePerOneMillion,
    double recoveredPerOneMillion,
    double criticalPerOneMillion,
    int affectedCountries,
  }) =>
      GlobalStats(
        updated: updated ?? this.updated,
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
        activePerOneMillion: activePerOneMillion ?? this.activePerOneMillion,
        recoveredPerOneMillion:
            recoveredPerOneMillion ?? this.recoveredPerOneMillion,
        criticalPerOneMillion:
            criticalPerOneMillion ?? this.criticalPerOneMillion,
        affectedCountries: affectedCountries ?? this.affectedCountries,
      );

  factory GlobalStats.fromRawJson(String str) =>
      GlobalStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalStats.fromJson(Map<String, dynamic> json) => GlobalStats(
        updated: json["updated"],
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"],
        deathsPerOneMillion: json["deathsPerOneMillion"].toDouble(),
        tests: json["tests"],
        testsPerOneMillion: json["testsPerOneMillion"].toDouble(),
        population: json["population"],
        activePerOneMillion: json["activePerOneMillion"].toDouble(),
        recoveredPerOneMillion: json["recoveredPerOneMillion"].toDouble(),
        criticalPerOneMillion: json["criticalPerOneMillion"].toDouble(),
        affectedCountries: json["affectedCountries"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
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
        "activePerOneMillion": activePerOneMillion,
        "recoveredPerOneMillion": recoveredPerOneMillion,
        "criticalPerOneMillion": criticalPerOneMillion,
        "affectedCountries": affectedCountries,
      };
}
