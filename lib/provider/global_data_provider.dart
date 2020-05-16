import 'package:coronatracker/models/global_stats.dart';
import 'package:coronatracker/services/web_api_handler.dart';
import 'package:flutter/cupertino.dart';

class GlobalData extends ChangeNotifier {
  GlobalStats _globalData;
  bool isFetchingData = false;
  GlobalData();

  void fetchGlobalData() async {
    isFetchingData = true;
    notifyListeners();
    _globalData = await CallWebService().getGlobalStats();
    isFetchingData = false;
    notifyListeners();
  }

  GlobalStats getGlobalStat() {
    if (_globalData != null) {
      return _globalData;
    }
    return null;
  }
}
