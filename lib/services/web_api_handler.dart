import 'dart:convert';

import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/models/global_stats.dart';
import 'package:coronatracker/models/india_stats.dart';
import 'package:http/http.dart' as http;

const all_stats_url = 'https://corona.lmao.ninja/v2/all';
const all_country_stats_url =
    'https://corona.lmao.ninja/v2/countries?sort=cases';
const all_country_namewise_url =
    'https://corona.lmao.ninja/v2/countries?sort=name';
const specific_country_stats_url = 'https://corona.lmao.ninja/v2/countries/';
const india_stats_url = 'https://api.covid19india.org/data.json';

class CallWebService {
  String countryCode;
  CallWebService({this.countryCode});
  Future<GlobalStats> getGlobalStats() async {
    final response = await http.get(all_stats_url);

    if (response.statusCode == 200) {
      //final responseJson = jsonDecode(response.body);
      GlobalStats g = GlobalStats.fromRawJson(response.body.toString());

      print(g.toString());

      return GlobalStats.fromRawJson(response.body.toString());
    } else {
      throw 'Data not fetched';
    }
  }

  Future<List<CountryStats>> getAllCountryStats() async {
    final response = await http.get(all_country_stats_url);
    List<CountryStats> allCountryStatsList = [];
    if (response.statusCode == 200) {
      final ac_statList = jsonDecode(response.body) as List;
      print('length ${ac_statList.length}');
      ac_statList.forEach((element) {
        allCountryStatsList.add(CountryStats.fromJson(element));
      });

      print(allCountryStatsList.toString());

      return allCountryStatsList;
    } else {
      throw 'Data not fetched';
    }
  }

  Future<List<CountryStats>> getAlphabeticCountryList() async {
    final response = await http.get(all_country_namewise_url);
    List<CountryStats> allCountryStatsList = [];
    if (response.statusCode == 200) {
      final ac_statList = jsonDecode(response.body) as List;
      print('length ${ac_statList.length}');
      ac_statList.forEach((element) {
        print(element.toString());
        allCountryStatsList.add(CountryStats.fromJson(element));
      });

      return allCountryStatsList;
    } else {
      throw 'Data not fetched';
    }
  }

  Future<IndiaStats> getIndiaStats() async {
    final response = await http.get(india_stats_url);

    if (response.statusCode == 200) {
      final indiaStats = jsonDecode(response.body);

      return IndiaStats.fromJson(indiaStats);
    } else {
      throw 'Data not fetched';
    }
  }

  Future<CountryStats> getCountryData() async {
    if (countryCode != null) {
      final response = await http.get(specific_country_stats_url + countryCode);

      if (response.statusCode == 200) {
        //final responseJson = jsonDecode(response.body);
        CountryStats g = CountryStats.fromRawJson(response.body.toString());
        print('country data load $countryCode');
        return CountryStats.fromRawJson(response.body.toString());
      } else {
        throw 'Data not fetched';
      }
    } else {
      throw 'No Country Selected';
    }
  }
}
