import 'dart:async';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/models/bucket/bucket_list.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space_list.dart';

import '../network/apis/user_api.dart';
import '../sharedpref/shared_preference_helper.dart';

@lazySingleton
class UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // api injection
  final UserApi _userApi;

  // constructor
  UserRepository(this._userApi, this._sharedPrefsHelper);

  Future<String> getUserNickname() async {
    return _userApi.getUserNickname();
  }

  String? getAuthToekn() {
    return _sharedPrefsHelper.authToken;
  }

  Future<List<String>> getCategories() async {
    return await _userApi.getCategories();
  }

  Future<BucketList> getBucketList() async {
    return await _userApi.getBucketList();
  }

  Future<User> getUserInfo() async {
    return await _userApi.getUserInfo();
  }

  Future<WiberSpaceList> getWiberSpaceListByUser(String userId) async {
    return await _userApi.getWiberSpaceListByUser(userId);
  }

  Future<dynamic> createUser({
    required String username,
    required String app_uuid,
    required String push_token,
  }) async {
    return await _userApi.createUser(
      username: username,
      app_uuid: app_uuid,
      push_token: push_token,
    );
  }

  String? getUuid() {
    return _sharedPrefsHelper.uuid;
  }

  String? getUserId() {
    return _sharedPrefsHelper.userId;
  }

  Future<bool?> saveUuid() async {
    return await _sharedPrefsHelper.saveUuid();
  }

  Future<bool?> saveUserId({required String userId}) async {
    return await _sharedPrefsHelper.saveUserId(userId);
  }

  Future saveProfileImage({
    required MultipartFile profileImage,
    required String userId,
    required String uuid,
  }) async {
    return await _userApi.saveProfileImage(
      profileImage: profileImage,
      userId: userId,
      uuid: uuid,
    );
  }
}
