// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_nickname_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SetNicknameStore on _SetNicknameStore, Store {
  late final _$nicknameAtom =
      Atom(name: '_SetNicknameStore.nickname', context: context);

  @override
  String get nickname {
    _$nicknameAtom.reportRead();
    return super.nickname;
  }

  @override
  set nickname(String value) {
    _$nicknameAtom.reportWrite(value, super.nickname, () {
      super.nickname = value;
    });
  }

  late final _$_SetNicknameStoreActionController =
      ActionController(name: '_SetNicknameStore', context: context);

  @override
  void setNickname(String val) {
    final _$actionInfo = _$_SetNicknameStoreActionController.startAction(
        name: '_SetNicknameStore.setNickname');
    try {
      return super.setNickname(val);
    } finally {
      _$_SetNicknameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetNickname() {
    final _$actionInfo = _$_SetNicknameStoreActionController.startAction(
        name: '_SetNicknameStore.resetNickname');
    try {
      return super.resetNickname();
    } finally {
      _$_SetNicknameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nickname: ${nickname}
    ''';
  }
}
