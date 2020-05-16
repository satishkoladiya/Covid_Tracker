import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceProvider extends ChangeNotifier {
  SharedPreferences _sharedPreferences;
  SharedPrefrenceProvider(this._sharedPreferences);

  void addKeyToSharedPref(String key, String value) {
    if (_sharedPreferences != null) {
      _sharedPreferences.setString(key, value);
      notifyListeners();
    }
  }

  SharedPreferences getSharedPrefrence() {
    return _sharedPreferences;
  }
}
