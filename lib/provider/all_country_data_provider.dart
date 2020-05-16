import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/services/web_api_handler.dart';
import 'package:flutter/cupertino.dart';

class AllCountryData extends ChangeNotifier {
  List<CountryStats> _listCountryStats;
  CountryStats _countryStats;
  bool isFetching = false;

  void fetchAllCountryStats() async {
    isFetching = true;
    notifyListeners();

    _listCountryStats = await CallWebService().getAllCountryStats();
    isFetching = false;
    notifyListeners();
  }

  void fetchCountryStats(String countryCode) async {
    isFetching = true;
    notifyListeners();

    _countryStats =
        await CallWebService(countryCode: countryCode).getCountryData();
    isFetching = false;
    notifyListeners();
  }

  void fetchAlphaAllCountryStats() async {
    isFetching = true;
    notifyListeners();

    _listCountryStats = await CallWebService().getAlphabeticCountryList();
    isFetching = false;

    notifyListeners();
  }

  CountryStats getCountryData() {
    if (_countryStats != null) {
      return _countryStats;
    }
    return null;
  }

  List<CountryStats> getAllCountryStats() {
    if (_listCountryStats != null && _listCountryStats.length > 0) {
      return _listCountryStats;
    }
    return null;
  }
}
