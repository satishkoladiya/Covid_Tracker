// To parse this JSON data, do
//
//     final indiaStats = indiaStatsFromJson(jsonString);

import 'dart:convert';

class IndiaStats {
  final List<CasesTimeSery> casesTimeSeries;
  final List<Statewise> statewise;
  final List<Tested> tested;

  IndiaStats({
    this.casesTimeSeries,
    this.statewise,
    this.tested,
  });

  IndiaStats copyWith({
    List<CasesTimeSery> casesTimeSeries,
    List<Statewise> statewise,
    List<Tested> tested,
  }) =>
      IndiaStats(
        casesTimeSeries: casesTimeSeries ?? this.casesTimeSeries,
        statewise: statewise ?? this.statewise,
        tested: tested ?? this.tested,
      );

  factory IndiaStats.fromRawJson(String str) =>
      IndiaStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndiaStats.fromJson(Map<String, dynamic> json) => IndiaStats(
        casesTimeSeries: List<CasesTimeSery>.from(
            json["cases_time_series"].map((x) => CasesTimeSery.fromJson(x))),
        statewise: List<Statewise>.from(
            json["statewise"].map((x) => Statewise.fromJson(x))),
        tested:
            List<Tested>.from(json["tested"].map((x) => Tested.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cases_time_series":
            List<dynamic>.from(casesTimeSeries.map((x) => x.toJson())),
        "statewise": List<dynamic>.from(statewise.map((x) => x.toJson())),
        "tested": List<dynamic>.from(tested.map((x) => x.toJson())),
      };
}

class CasesTimeSery {
  final String dailyconfirmed;
  final String dailydeceased;
  final String dailyrecovered;
  final String date;
  final String totalconfirmed;
  final String totaldeceased;
  final String totalrecovered;

  CasesTimeSery({
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.date,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
  });

  CasesTimeSery copyWith({
    String dailyconfirmed,
    String dailydeceased,
    String dailyrecovered,
    String date,
    String totalconfirmed,
    String totaldeceased,
    String totalrecovered,
  }) =>
      CasesTimeSery(
        dailyconfirmed: dailyconfirmed ?? this.dailyconfirmed,
        dailydeceased: dailydeceased ?? this.dailydeceased,
        dailyrecovered: dailyrecovered ?? this.dailyrecovered,
        date: date ?? this.date,
        totalconfirmed: totalconfirmed ?? this.totalconfirmed,
        totaldeceased: totaldeceased ?? this.totaldeceased,
        totalrecovered: totalrecovered ?? this.totalrecovered,
      );

  factory CasesTimeSery.fromRawJson(String str) =>
      CasesTimeSery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CasesTimeSery.fromJson(Map<String, dynamic> json) => CasesTimeSery(
        dailyconfirmed: json["dailyconfirmed"],
        dailydeceased: json["dailydeceased"],
        dailyrecovered: json["dailyrecovered"],
        date: json["date"],
        totalconfirmed: json["totalconfirmed"],
        totaldeceased: json["totaldeceased"],
        totalrecovered: json["totalrecovered"],
      );

  Map<String, dynamic> toJson() => {
        "dailyconfirmed": dailyconfirmed,
        "dailydeceased": dailydeceased,
        "dailyrecovered": dailyrecovered,
        "date": date,
        "totalconfirmed": totalconfirmed,
        "totaldeceased": totaldeceased,
        "totalrecovered": totalrecovered,
      };
}

class Statewise {
  final String active;
  final String confirmed;
  final String deaths;
  final String deltaconfirmed;
  final String deltadeaths;
  final String deltarecovered;
  final String lastupdatedtime;
  final String recovered;
  final String state;
  final String statecode;
  final String statenotes;

  Statewise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.recovered,
    this.state,
    this.statecode,
    this.statenotes,
  });

  Statewise copyWith({
    String active,
    String confirmed,
    String deaths,
    String deltaconfirmed,
    String deltadeaths,
    String deltarecovered,
    String lastupdatedtime,
    String recovered,
    String state,
    String statecode,
    String statenotes,
  }) =>
      Statewise(
        active: active ?? this.active,
        confirmed: confirmed ?? this.confirmed,
        deaths: deaths ?? this.deaths,
        deltaconfirmed: deltaconfirmed ?? this.deltaconfirmed,
        deltadeaths: deltadeaths ?? this.deltadeaths,
        deltarecovered: deltarecovered ?? this.deltarecovered,
        lastupdatedtime: lastupdatedtime ?? this.lastupdatedtime,
        recovered: recovered ?? this.recovered,
        state: state ?? this.state,
        statecode: statecode ?? this.statecode,
        statenotes: statenotes ?? this.statenotes,
      );

  factory Statewise.fromRawJson(String str) =>
      Statewise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Statewise.fromJson(Map<String, dynamic> json) => Statewise(
        active: json["active"],
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        deltaconfirmed: json["deltaconfirmed"],
        deltadeaths: json["deltadeaths"],
        deltarecovered: json["deltarecovered"],
        lastupdatedtime: json["lastupdatedtime"],
        recovered: json["recovered"],
        state: json["state"],
        statecode: json["statecode"],
        statenotes: json["statenotes"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "confirmed": confirmed,
        "deaths": deaths,
        "deltaconfirmed": deltaconfirmed,
        "deltadeaths": deltadeaths,
        "deltarecovered": deltarecovered,
        "lastupdatedtime": lastupdatedtime,
        "recovered": recovered,
        "state": state,
        "statecode": statecode,
        "statenotes": statenotes,
      };
}

class Tested {
  final String individualstestedperconfirmedcase;
  final String positivecasesfromsamplesreported;
  final String samplereportedtoday;
  final String source;
  final String testpositivityrate;
  final String testsconductedbyprivatelabs;
  final String testsperconfirmedcase;
  final String totalindividualstested;
  final String totalpositivecases;
  final String totalsamplestested;
  final String updatetimestamp;

  Tested({
    this.individualstestedperconfirmedcase,
    this.positivecasesfromsamplesreported,
    this.samplereportedtoday,
    this.source,
    this.testpositivityrate,
    this.testsconductedbyprivatelabs,
    this.testsperconfirmedcase,
    this.totalindividualstested,
    this.totalpositivecases,
    this.totalsamplestested,
    this.updatetimestamp,
  });

  Tested copyWith({
    String individualstestedperconfirmedcase,
    String positivecasesfromsamplesreported,
    String samplereportedtoday,
    String source,
    String testpositivityrate,
    String testsconductedbyprivatelabs,
    String testsperconfirmedcase,
    String totalindividualstested,
    String totalpositivecases,
    String totalsamplestested,
    String updatetimestamp,
  }) =>
      Tested(
        individualstestedperconfirmedcase: individualstestedperconfirmedcase ??
            this.individualstestedperconfirmedcase,
        positivecasesfromsamplesreported: positivecasesfromsamplesreported ??
            this.positivecasesfromsamplesreported,
        samplereportedtoday: samplereportedtoday ?? this.samplereportedtoday,
        source: source ?? this.source,
        testpositivityrate: testpositivityrate ?? this.testpositivityrate,
        testsconductedbyprivatelabs:
            testsconductedbyprivatelabs ?? this.testsconductedbyprivatelabs,
        testsperconfirmedcase:
            testsperconfirmedcase ?? this.testsperconfirmedcase,
        totalindividualstested:
            totalindividualstested ?? this.totalindividualstested,
        totalpositivecases: totalpositivecases ?? this.totalpositivecases,
        totalsamplestested: totalsamplestested ?? this.totalsamplestested,
        updatetimestamp: updatetimestamp ?? this.updatetimestamp,
      );

  factory Tested.fromRawJson(String str) => Tested.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tested.fromJson(Map<String, dynamic> json) => Tested(
        individualstestedperconfirmedcase:
            json["individualstestedperconfirmedcase"],
        positivecasesfromsamplesreported:
            json["positivecasesfromsamplesreported"],
        samplereportedtoday: json["samplereportedtoday"],
        source: json["source"],
        testpositivityrate: json["testpositivityrate"],
        testsconductedbyprivatelabs: json["testsconductedbyprivatelabs"],
        testsperconfirmedcase: json["testsperconfirmedcase"],
        totalindividualstested: json["totalindividualstested"],
        totalpositivecases: json["totalpositivecases"],
        totalsamplestested: json["totalsamplestested"],
        updatetimestamp: json["updatetimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "individualstestedperconfirmedcase": individualstestedperconfirmedcase,
        "positivecasesfromsamplesreported": positivecasesfromsamplesreported,
        "samplereportedtoday": samplereportedtoday,
        "source": source,
        "testpositivityrate": testpositivityrate,
        "testsconductedbyprivatelabs": testsconductedbyprivatelabs,
        "testsperconfirmedcase": testsperconfirmedcase,
        "totalindividualstested": totalindividualstested,
        "totalpositivecases": totalpositivecases,
        "totalsamplestested": totalsamplestested,
        "updatetimestamp": updatetimestamp,
      };
}
