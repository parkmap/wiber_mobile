import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/models/faq/faq.dart';

part 'setting_ui_store.g.dart';

@injectable
class SettingUiStore = _SettingUiStore with _$SettingUiStore;

abstract class _SettingUiStore with Store {
  // repository instance

  // store variables:-----------------------------------------------------------
  @observable
  XFile? profileImage;

  @observable
  bool isUpdatingUserInfo = false;

  // getters:-------------------------------------------------------------------

  // constructor:---------------------------------------------------------------
  // actions:-------------------------------------------------------------------
  @action
  void setProfileImage(XFile val) {
    profileImage = val;
  }

  @action
  void resetProfileImage() {
    profileImage = null;
  }

  @action
  void toggleIsUpdatingUserInfo() {
    isUpdatingUserInfo = !isUpdatingUserInfo;
  }
}
