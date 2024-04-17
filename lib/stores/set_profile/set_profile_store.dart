import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'set_profile_store.g.dart';

@injectable
class SetProfileStore = _SetProfileStore with _$SetProfileStore;

abstract class _SetProfileStore with Store {
  // repository instance

  // store variables:-----------------------------------------------------------
  String defaultProfilePath = "assets/images/default_profile_image.png";

  @observable
  XFile? profileImage;

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
}
