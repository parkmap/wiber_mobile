import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';

part 'user_store.g.dart';

@injectable
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final UserRepository _userRepository;

  // store variables:-----------------------------------------------------------

  @observable
  List<dynamic> wiberList = [];

  @observable
  List<String> categories = [];

  @observable
  List<Bucket> bucketList = [];

  @observable
  List<Bucket> filteredBucketList = [];

  @observable
  List<WiberSpace> wiberSpaceList = [];

  @observable
  bool isCreatingUser = false;

  @observable
  bool isLoadingWiberspace = false;

  @observable
  User? user;

  // getters:-------------------------------------------------------------------

  // constructor:---------------------------------------------------------------
  _UserStore(UserRepository userRepository)
      : _userRepository = userRepository {}

  // actions:-------------------------------------------------------------------

  @action
  String? getUuid() {
    return _userRepository.getUuid();
  }

  @action
  Future<bool?> saveUuid() async {
    return await _userRepository.saveUuid();
  }

  @action
  String? getUserId() {
    return _userRepository.getUserId();
  }

  @action
  Future<void> getUserInfo() async {
    DateTime now = DateTime.now();
    var res = _userRepository.selfInfo;

    if (res != null &&
        now.difference(DateTime.parse(res.refreshedAt)).inHours < 24) {
      user = res;
      return;
    } else {
      var tempRes = await _userRepository.getUserInfo();
      User tempUser = User(
        id: getUserId()!,
        nickname: tempRes.data['username'],
        profileImageUrl: tempRes.data['image'] ?? '',
        refreshedAt: DateTime.now().toString(),
      );

      await _userRepository.saveSelfInfo(tempUser);
      user = tempUser;

      return;
    }
  }

  @action
  Future<void> refreshUserInfo() async {
    var tempRes = await _userRepository.getUserInfo();
    User tempUser = User(
      id: getUserId()!,
      nickname: tempRes.data['username'],
      profileImageUrl: tempRes.data['image'] ?? '',
      refreshedAt: DateTime.now().toString(),
    );

    await _userRepository.saveSelfInfo(tempUser);
    user = tempUser;

    return;
  }

  @action
  Future updateUserInfo({
    required String userNickname,
    required String pushToken,
  }) async {
    try {
      var res = await _userRepository.updateUserInfo(
        userId: getUserId()!,
        userNickname: userNickname,
        pushToken: pushToken,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future createUser({required String username}) async {
    if (isCreatingUser || getUuid() == null) return;

    isCreatingUser = true;
    try {
      var res = await _userRepository.createUser(
        username: username,
        app_uuid: getUuid()!,
        push_token: "test",
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future saveProfileImage({required Uint8List profileImage}) async {
    try {
      var res =
          await _userRepository.saveProfileImage(profileImage: profileImage);
      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future<void> saveUserId({required String userId}) async {
    await _userRepository.saveUserId(userId: userId);
  }

  @action
  Future<void> getWiberSpaceList() async {
    isLoadingWiberspace = true;

    try {
      var res = await _userRepository.getWiberSpaceList();

      var ownedSpace = res.data['space_owned']
          as List<dynamic>; // 'as List<dynamic>'를 추가하여 명시적으로 타입을 선언
      var joinedSpace = res.data['space_joined'] as List<dynamic>;

      List<WiberSpace> ownedSpaceList = ownedSpace.isNotEmpty
          ? await Future.wait(
              ownedSpace.map((space) async {
                List<User> memberData = await Future.wait(
                    (space['members'] as List<dynamic>).map((user) async {
                      DateTime now = DateTime.now();
                      var data =
                          await _userRepository.getOtherUserInfo(userId: user);

                      if (data != null &&
                          now
                                  .difference(DateTime.parse(data.refreshedAt))
                                  .inHours <
                              24) {
                        return data;
                      } else {
                        var userInfo =
                            await _userRepository.getUserInfo(userId: user);
                        User userData = User(
                            id: user,
                            nickname: userInfo.data['username'],
                            profileImageUrl: userInfo.data['image'] ?? '',
                            refreshedAt: DateTime.now().toString());

                        await _userRepository.saveOtherUserInfo(userData);
                        return userData;
                      }
                    }).toList(),
                    eagerError: true);

                return WiberSpace(
                  id: space['space_id'],
                  title: space['title'],
                  isFavorite: space['is_favorite'] ?? false,
                  maxCount: space['bucket_count'],
                  completeCount: space['done_count'],
                  owner: space['owner'],
                  members: memberData,
                );
              }).toList(),
              eagerError: true)
          : [];

      List<WiberSpace> joinedSpaceList = joinedSpace.isNotEmpty
          ? await Future.wait(
              joinedSpace.map((space) async {
                List<User> memberData = await Future.wait(
                    (space['members'] as List<dynamic>).map((user) async {
                      DateTime now = DateTime.now();
                      var data =
                          await _userRepository.getOtherUserInfo(userId: user);

                      if (data != null &&
                          now
                                  .difference(DateTime.parse(data.refreshedAt))
                                  .inHours <
                              24) {
                        return data;
                      } else {
                        var userInfo =
                            await _userRepository.getUserInfo(userId: user);
                        User userData = User(
                            id: user,
                            nickname: userInfo.data['username'],
                            profileImageUrl: userInfo.data['image'] ?? '',
                            refreshedAt: DateTime.now().toString());

                        await _userRepository.saveOtherUserInfo(userData);
                        return userData;
                      }
                    }).toList(),
                    eagerError: true);

                return WiberSpace(
                  id: space['space_id'],
                  title: space['title'],
                  isFavorite: space['is_favorite'] ?? false,
                  maxCount: space['bucket_count'],
                  completeCount: space['done_count'],
                  owner: space['owner'],
                  members: memberData,
                );
              }).toList(),
              eagerError: true)
          : [];

      wiberSpaceList = [
        ...ownedSpaceList,
        ...joinedSpaceList,
      ];

      isLoadingWiberspace = false;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future createWiberSpace({required String title}) async {
    try {
      var res = await _userRepository.createWiberSpace(title: title);

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future updateWiberSpace({
    required String spaceId,
    required String title,
  }) async {
    try {
      var res = await _userRepository.updateWiberSpace(
        spaceId: spaceId,
        title: title,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future deleteWiberSpace({required String spaceId}) async {
    try {
      var res = await _userRepository.deleteWiberSpace(spaceId: spaceId);

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future<void> getCategoryList({
    required String spaceId,
  }) async {
    try {
      var res = await _userRepository.getCategoryList(
        spaceId: spaceId,
      );
    } catch (err) {
      print(err);
    }
  }

  @action
  Future createCategory({
    required String spaceId,
    required String title,
  }) async {
    try {
      var res = await _userRepository.createCategory(
        spaceId: spaceId,
        title: title,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future updateCategory({
    required String spaceId,
    required String categoryId,
    required String title,
  }) async {
    try {
      var res = await _userRepository.updateCategory(
        spaceId: spaceId,
        categoryId: categoryId,
        title: title,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future deleteCategory({
    required String spaceId,
    required String categoryId,
  }) async {
    try {
      var res = await _userRepository.deleteCategory(
        spaceId: spaceId,
        categoryId: categoryId,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future<void> getBucketList({
    required String spaceId,
    String? categoryId,
    String? state,
  }) async {
    try {
      var res = await _userRepository.getBucketList(
        spaceId: spaceId,
        categoryId: categoryId,
        state: state,
      );
    } catch (err) {
      print(err);
    }
  }

  @action
  Future createBucket({
    required String spaceId,
    required String title,
    required String content,
  }) async {
    try {
      var res = await _userRepository.createBucket(
        spaceId: spaceId,
        title: title,
        content: content,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future updateBucket(
      {required String spaceId,
      required String categoryId,
      required String bucketId,
      required String title,
      required String content}) async {
    try {
      var res = await _userRepository.updateBucket(
        spaceId: spaceId,
        categoryId: categoryId,
        bucketId: bucketId,
        title: title,
        content: content,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future deleteBucket({
    required String spaceId,
    required String bucketId,
  }) async {
    try {
      var res = await _userRepository.deleteBucket(
        spaceId: spaceId,
        bucketId: bucketId,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }
}
