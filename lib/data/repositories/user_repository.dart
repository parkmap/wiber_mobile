import 'dart:async';
import 'dart:typed_data';
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

  String? getAuthToekn() {
    return _sharedPrefsHelper.authToken;
  }

  Future getUserInfo({String? userId}) async {
    return await _userApi.getUserInfo(
      userId: userId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future<bool> saveSelfInfo(User user) async {
    return await _sharedPrefsHelper.saveSelfInfo(user);
  }

  User? get selfInfo {
    return _sharedPrefsHelper.selfInfo;
  }

  Future<void> logout() async {
    await _sharedPrefsHelper.removeUserId();
    await _sharedPrefsHelper.removeUuid();
  }

  Future createUser({
    required String username,
    required String app_uuid,
  }) async {
    return await _userApi.createUser(
      username: username,
      app_uuid: app_uuid,
    );
  }

  Future updateUserInfo({
    required String userId,
    required String userNickname,
    String? pushToken,
  }) async {
    return await _userApi.updateUserInfo(
      userId: userId,
      userNickname: userNickname,
      pushToken: pushToken,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  String? getUuid() {
    return _sharedPrefsHelper.uuid;
  }

  String? getUserId() {
    return _sharedPrefsHelper.userId;
  }

  User? getOtherUserInfo({required String userId}) {
    return _sharedPrefsHelper.getOtherUserInfo(userId: userId);
  }

  Future<bool> saveOtherUserInfo(User user) {
    return _sharedPrefsHelper.saveOtherUserInfo(user);
  }

  Future<bool?> saveUuid() async {
    return await _sharedPrefsHelper.saveUuid();
  }

  Future<bool?> saveUserId({required String userId}) async {
    return await _sharedPrefsHelper.saveUserId(userId);
  }

  Future saveProfileImage({required Uint8List profileImage}) async {
    return await _userApi.saveProfileImage(
      profileImage: profileImage,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future deleteProfileImage() async {
    return await _userApi.deleteProfileImage(
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future getWiberSpaceList() async {
    return await _userApi.getWiberSpaceList(
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future createWiberSpace({
    required String title,
  }) async {
    return await _userApi.createWiberSpace(
      title: title,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future updateWiberSpace({
    required String spaceId,
    required String title,
  }) async {
    return await _userApi.updateWiberSpace(
      spaceId: spaceId,
      title: title,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future deleteWiberSpace({
    required String spaceId,
  }) async {
    return await _userApi.deleteWiberSpace(
      spaceId: spaceId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future leaveWiberSpace({
    required String spaceId,
  }) async {
    return await _userApi.leaveWiberSpace(
      spaceId: spaceId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future createWiberSpaceInviteLink({
    required String spaceId,
  }) async {
    return await _userApi.createWiberSpaceInviteLink(
      spaceId: spaceId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future kickUserFromWiberSpace({
    required String spaceId,
    required String exitId,
  }) async {
    return await _userApi.kickUserFromWiberSpace(
      spaceId: spaceId,
      exitId: exitId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future changeOwnerOfWiberSpace({
    required String spaceId,
    required String userId,
  }) async {
    return await _userApi.changeOwnerOfWiberSpace(
      spaceId: spaceId,
      userId: userId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future enterWiberSpaceInvitation() async {
    var res = await _userApi.enterWiberSpaceInvitation(
      spaceId: _sharedPrefsHelper.tempSpaceId!,
      shareId: _sharedPrefsHelper.tempShareId!,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );

    if (res != null && res != DioException) {
      await _sharedPrefsHelper.removeTempSpaceId();
      await _sharedPrefsHelper.removeTempShareId();
    }
    return res;
  }

  Future getCategoryList({required String spaceId}) async {
    return await _userApi.getCategoryList(
      spaceId: spaceId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future createCategory({
    required String spaceId,
    required String title,
  }) async {
    return await _userApi.createCategory(
      title: title,
      spaceId: spaceId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future updateCategory({
    required String spaceId,
    required String categoryId,
    required String title,
  }) async {
    return await _userApi.updateCategory(
      spaceId: spaceId,
      categoryId: categoryId,
      title: title,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future deleteCategory({
    required String spaceId,
    required String categoryId,
  }) async {
    return await _userApi.deleteCategory(
      spaceId: spaceId,
      categoryId: categoryId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future getBucketList({
    required String spaceId,
    String? categoryId,
    String? state,
  }) async {
    return await _userApi.getBucketList(
      spaceId: spaceId,
      categoryId: categoryId,
      state: state,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future createBucket({
    required String spaceId,
    required String categoryId,
    required String title,
    required String content,
    required String state,
    required String date,
  }) async {
    return await _userApi.createBucket(
      title: title,
      content: content,
      spaceId: spaceId,
      categoryId: categoryId,
      state: state,
      date: date,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future updateBucket({
    required String spaceId,
    required String categoryId,
    required String bucketId,
    String? state,
    String? date,
    String? title,
    String? content,
  }) async {
    return await _userApi.updateBucket(
      spaceId: spaceId,
      categoryId: categoryId,
      bucketId: bucketId,
      state: state,
      title: title,
      date: date,
      content: content,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future deleteBucket({
    required String spaceId,
    required String bucketId,
  }) async {
    return await _userApi.deleteBucket(
      spaceId: spaceId,
      bucketId: bucketId,
      username: _sharedPrefsHelper.userId!,
      password: _sharedPrefsHelper.uuid!,
    );
  }

  Future getFaq() async {
    return await _userApi.getFaq();
  }

  Future getNotice() async {
    return await _userApi.getNotice();
  }
}
