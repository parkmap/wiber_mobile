import 'dart:async';
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
}
