import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/repository.dart';

part 'set_nickname_store.g.dart';

@injectable
class SetNicknameStore = _SetNicknameStore with _$SetNicknameStore;

abstract class _SetNicknameStore with Store {
  // repository instance

  // store variables:-----------------------------------------------------------
  @observable
  String nickname = '';

  // getters:-------------------------------------------------------------------
  bool get isNicknmeValid =>
      nickname.isNotEmpty && nickname != '' && nickname.trim() != '';

  // constructor:---------------------------------------------------------------

  // actions:-------------------------------------------------------------------
  @action
  void setNickname(String val) {
    nickname = val;
  }

  @action
  void resetNickname() {
    nickname = '';
  }
}
