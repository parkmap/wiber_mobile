import 'dart:async';

import 'package:injectable/injectable.dart';
import '../sharedpref/shared_preference_helper.dart';

@singleton
class Repository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._sharedPrefsHelper);

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;

  // App mode: -----------------------------------------------------------------
  String? get appMode => _sharedPrefsHelper.appMode;

  Future<bool> saveAppMode(String val) async {
    return _sharedPrefsHelper.saveAppMode(val);
  }

  Future<bool> removeAppMode() async {
    return _sharedPrefsHelper.removeAppMode();
  }
}
