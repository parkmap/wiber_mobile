// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$nicknameAtom =
      Atom(name: '_UserStore.nickname', context: context);

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

  late final _$getUserNicknameAsyncAction =
      AsyncAction('_UserStore.getUserNickname', context: context);

  @override
  Future<void> getUserNickname() {
    return _$getUserNicknameAsyncAction.run(() => super.getUserNickname());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  String? getAuthToken() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.getAuthToken');
    try {
      return super.getAuthToken();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nickname: ${nickname}
    ''';
  }
}
