import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/category/category.dart';
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
  List<Category> categories = [];

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
  bool isLoadingBucket = false;

  @observable
  User? user;

  @observable
  List<dynamic> faqList = [];

  @observable
  List<dynamic> noticeList = [];

  @observable
  bool isLoadingFaq = false;

  @observable
  bool isLoadingNotice = false;

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
  Future<void> logout() async {
    await _userRepository.logout();
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
    String? pushToken,
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
  Future deleteProfileImage() async {
    try {
      var res = await _userRepository.deleteProfileImage();
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
                List<User> memberData = space['members'] != null
                    ? await Future.wait(
                        (space['members'] as List<dynamic>).map((user) async {
                          DateTime now = DateTime.now();
                          var data = await _userRepository.getOtherUserInfo(
                              userId: user);

                          if (data != null &&
                              now
                                      .difference(
                                          DateTime.parse(data.refreshedAt))
                                      .inHours <
                                  24) {
                            return data;
                          } else {
                            return await userInfo(user);
                          }
                        }).toList(),
                        eagerError: true)
                    : [user!];

                return WiberSpace(
                  id: space['space_id'],
                  title: space['title'],
                  isFavorite: space['is_favorite'] ?? false,
                  maxCount: space['bucket_count'] ?? 0,
                  completeCount: space['done_count'] ?? 0,
                  owner: space['owner'],
                  members: memberData,
                );
              }).toList(),
              eagerError: true)
          : [];

      List<WiberSpace> joinedSpaceList = joinedSpace.isNotEmpty
          ? await Future.wait(
              joinedSpace.map((space) async {
                List<User> memberData = space['members'] != null
                    ? await Future.wait(
                        (space['members'] as List<dynamic>).map((user) async {
                          DateTime now = DateTime.now();
                          var data = await _userRepository.getOtherUserInfo(
                              userId: user);

                          if (data != null &&
                              now
                                      .difference(
                                          DateTime.parse(data.refreshedAt))
                                      .inHours <
                                  24) {
                            return data;
                          } else {
                            return await userInfo(user);
                          }
                        }).toList(),
                        eagerError: true)
                    : [user!];

                return WiberSpace(
                  id: space['space_id'],
                  title: space['title'],
                  isFavorite: space['is_favorite'] ?? false,
                  maxCount: space['bucket_count'] ?? 0,
                  completeCount: space['done_count'] ?? 0,
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

  Future<User> userInfo(user) async {
    try {
      var userInfo = await _userRepository.getUserInfo(userId: user);
      User userData = User(
          id: user,
          nickname: userInfo.data['username'],
          profileImageUrl: userInfo.data['image'] ?? '',
          refreshedAt: DateTime.now().toString());

      await _userRepository.saveOtherUserInfo(userData);
      return userData;
    } catch (err) {
      return User(
        id: user,
        nickname: '탈퇴한 사용자',
        profileImageUrl: '',
        refreshedAt: DateTime.now().toString(),
      );
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
  Future leaveWiberSpace({required String spaceId}) async {
    try {
      var res = await _userRepository.leaveWiberSpace(spaceId: spaceId);

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future createWiberSpaceInviteLink({required String spaceId}) async {
    try {
      var res =
          await _userRepository.createWiberSpaceInviteLink(spaceId: spaceId);

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future kickUserFromWiberSpace({
    required String spaceId,
    required String exitId,
  }) async {
    try {
      var res = await _userRepository.kickUserFromWiberSpace(
        spaceId: spaceId,
        exitId: exitId,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future enterWiberSpaceInvitation() async {
    try {
      var res = await _userRepository.enterWiberSpaceInvitation();

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future changeOwnerOfWiberSpace({
    required String spaceId,
    required String userId,
  }) async {
    try {
      var res = await _userRepository.changeOwnerOfWiberSpace(
        spaceId: spaceId,
        userId: userId,
      );

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

      categories = res.data["categories"]
          .map((el) => Category(
                id: el["id"],
                title: el["title"],
              ))
          .cast<Category>()
          .toList();
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
    int? state,
  }) async {
    isLoadingBucket = true;
    try {
      var res = await _userRepository.getBucketList(
        spaceId: spaceId,
        // categoryId: categoryId,
        // state: state,
      );

      List<Bucket> dataList = res.data["buckets"]
          .map((el) => Bucket(
                id: el["id"],
                title: el["title"],
                body: el["content"] ?? "",
                category: el["category_id"] ?? "",
                endDate: el["date"] == null || el["date"] == "null"
                    ? ""
                    : el["date"],
                isCompleted: el["state"] == "완료",
              ))
          .cast<Bucket>()
          .toList();

      bucketList = dataList;

      filterBucketList(categoryId: categoryId ?? "", status: state ?? 0);
    } catch (err) {
      print(err);
      isLoadingBucket = false;
    }
  }

  @action
  void filterBucketList({
    required String categoryId,
    required int status,
  }) {
    List<Bucket> copiedBucketList = List.from(bucketList);

    copiedBucketList = categoryId.isEmpty
        ? copiedBucketList
        : copiedBucketList
            .where((bucket) => bucket.category == categoryId)
            .toList();

    copiedBucketList = status == 0
        ? copiedBucketList
        : status == 1
            ? copiedBucketList.where((bucket) => !bucket.isCompleted).toList()
            : copiedBucketList.where((bucket) => bucket.isCompleted).toList();

    filteredBucketList = copiedBucketList;
    isLoadingBucket = false;
  }

  @action
  Future createBucket({
    required String spaceId,
    required String categoryId,
    required String title,
    required String content,
    required String state,
    required String date,
  }) async {
    try {
      var res = await _userRepository.createBucket(
        spaceId: spaceId,
        categoryId: categoryId,
        title: title,
        content: content,
        state: state,
        date: date,
      );

      return res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future updateBucket({
    required String spaceId,
    required String categoryId,
    required String bucketId,
    String? state,
    String? date,
    String? title,
    String? content,
  }) async {
    try {
      var res = await _userRepository.updateBucket(
        spaceId: spaceId,
        categoryId: categoryId,
        bucketId: bucketId,
        state: state,
        date: date,
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

  @action
  Future getFaq() async {
    try {
      isLoadingFaq = true;
      var res = await _userRepository.getFaq();

      faqList = res;
      isLoadingFaq = false;
    } catch (err) {
      isLoadingFaq = false;
      print(err);
    }
  }

  @action
  Future getNotice() async {
    try {
      isLoadingNotice = true;
      var res = await _userRepository.getNotice();

      noticeList = res;
      isLoadingNotice = false;
    } catch (err) {
      isLoadingNotice = false;
      print(err);
    }
  }
}
