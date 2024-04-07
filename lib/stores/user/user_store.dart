import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';

part 'user_store.g.dart';

@injectable
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final UserRepository _userRepository;

  // store variables:-----------------------------------------------------------
  @observable
  String nickname = '';

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
}
