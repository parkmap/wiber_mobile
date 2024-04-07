import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

@lazySingleton
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // App mode (shopi, user):--------------------------------------------------------
  Future<bool> saveAppMode(String value) async {
    return _sharedPreference.setString(Preferences.appMode, value);
  }

  String? get appMode {
    return _sharedPreference.getString(Preferences.appMode);
  }

  Future<bool> removeAppMode() async {
    return _sharedPreference.remove(Preferences.appMode);
  }

  // User:--------------------------------------------------------
  Future<bool> saveUserId(String value) async {
    return _sharedPreference.setString(Preferences.userId, value);
  }

  String? get userId {
    return _sharedPreference.getString(Preferences.userId);
  }

  Future<bool> removeUserId() async {
    return _sharedPreference.remove(Preferences.userId);
  }

  Future<bool> removeUser() async {
    return _sharedPreference.remove(Preferences.user);
  }

  // token managements
  String? get authToken {
    return _sharedPreference.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.authToken);
  }

  bool get isLoggedIn {
    return _sharedPreference.getString(Preferences.authToken) != null
        ? true
        : false;
  }

  // Theme:---------------------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }
}
