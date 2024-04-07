import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/models/listing/bucket.dart';

part 'user_store.g.dart';

@injectable
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final UserRepository _userRepository;

  // store variables:-----------------------------------------------------------
  @observable
  String nickname = '';

  @observable
  List<String> categories = [];

  @observable
  List<Bucket> bucketList = [];

  @observable
  List<Bucket> filteredBucketList = [];

  // getters:-------------------------------------------------------------------

  // constructor:---------------------------------------------------------------
  _UserStore(UserRepository userRepository)
      : _userRepository = userRepository {}

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getUserNickname() async {
    nickname = await _userRepository.getUserNickname();
  }

  @action
  String? getAuthToken() {
    return _userRepository.getAuthToekn();
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
}
