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
  String? getAuthToken() {
    return _userRepository.getAuthToekn();
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
  Future saveProfileImage({required MultipartFile profileImage}) async {
    try {
      var userId = await _userRepository.getUserId();
      var uuid = await _userRepository.getUuid();
      var res = await _userRepository.saveProfileImage(
          profileImage: profileImage, userId: userId!, uuid: uuid!);
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
  Future<void> getCategories() async {
    try {
      var res = await _userRepository.getCategories();
      categories = res;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future<void> getBucketList() async {
    try {
      var res = await _userRepository.getBucketList();
      bucketList = res.list;
      filteredBucketList =
          res.list.where((el) => el.category == categories[0]).toList();
    } catch (err) {
      print(err);
    }
  }

  @action
  void filterBucketList(String category, int status) {
    List<Bucket> filtered;
    switch (status) {
      case 0:
        filtered = bucketList.where((el) => el.category == category).toList();
        break;
      case 1:
        filtered = bucketList
            .where((el) => el.category == category && !el.isCompleted)
            .toList();
        break;
      case 2:
        filtered = bucketList
            .where((el) => el.category == category && el.isCompleted)
            .toList();
        break;
      default:
        filtered = bucketList.where((el) => el.category == category).toList();
        break;
    }

    filteredBucketList = filtered;
  }

  @action
  Future<void> getUserInfo() async {
    user = await _userRepository.getUserInfo();
  }

  @action
  Future<void> getWiberSpaceListByUser() async {
    if (user == null) return;

    try {
      var res = await _userRepository.getWiberSpaceListByUser(user!.id);
      wiberSpaceList = res.list;
    } catch (err) {
      print(err);
    }
  }

  @action
  Future<void> getUserInfoAndWiberSpaceList() async {
    try {
      var userRes = await _userRepository.getUserInfo();
      user = userRes;

      var listRes = await _userRepository.getWiberSpaceListByUser(userRes.id);
      wiberSpaceList = listRes.list;
    } catch (err) {
      print(err);
    }
  }
}
