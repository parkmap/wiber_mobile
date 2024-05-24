import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiber_mobile/models/user/user.dart';

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

  Future<bool> saveOtherUserInfo(User user) async {
    return _sharedPreference.setString(
        Preferences.otherUserInfo + user.id, jsonEncode(user.toJson()));
  }

  User? getOtherUserInfo({required String userId}) {
    var findUser =
        _sharedPreference.getString(Preferences.otherUserInfo + userId);
    if (findUser != null) {
      return User.fromJson(jsonDecode(findUser));
    }
    return null;
  }

  Future<bool> saveSelfInfo(User user) async {
    return _sharedPreference.setString(
        Preferences.selfInfo, jsonEncode(user.toJson()));
  }

  User? get selfInfo {
    var findUser = _sharedPreference.getString(Preferences.selfInfo);
    if (findUser != null) {
      return User.fromJson(jsonDecode(findUser));
    }
    return null;
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

  Future<bool?> saveUuid() async {
    var deviceInfo = DeviceInfoPlugin();
    var _androidIdPlugin = AndroidId();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;

      if (iosDeviceInfo.identifierForVendor != null) {
        return _sharedPreference.setString(
            Preferences.uuid, iosDeviceInfo.identifierForVendor!);
      }
    } else if (Platform.isAndroid) {
      String? androidId = await _androidIdPlugin.getId();

      if (androidId != null) {
        return _sharedPreference.setString(Preferences.uuid, androidId);
      }
    }
  }

  String? get uuid {
    return _sharedPreference.getString(Preferences.uuid);
  }

  Future<bool> removeUuid() async {
    return _sharedPreference.remove(Preferences.uuid);
  }

  Future<bool> saveTempSpaceId(String spaceId) async {
    return _sharedPreference.setString(Preferences.tempSpaceId, spaceId);
  }

  String? get tempSpaceId {
    return _sharedPreference.getString(Preferences.tempSpaceId);
  }

  Future<bool> removeTempSpaceId() async {
    return _sharedPreference.remove(Preferences.tempSpaceId);
  }

  Future<bool> saveTempShareId(String shareId) async {
    return _sharedPreference.setString(Preferences.tempShareId, shareId);
  }

  String? get tempShareId {
    return _sharedPreference.getString(Preferences.tempShareId);
  }

  Future<bool> removeTempShareId() async {
    return _sharedPreference.remove(Preferences.tempShareId);
  }
}
