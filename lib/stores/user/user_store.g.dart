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

  late final _$categoriesAtom =
      Atom(name: '_UserStore.categories', context: context);

  @override
  List<String> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<String> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$bucketListAtom =
      Atom(name: '_UserStore.bucketList', context: context);

  @override
  List<Bucket> get bucketList {
    _$bucketListAtom.reportRead();
    return super.bucketList;
  }

  @override
  set bucketList(List<Bucket> value) {
    _$bucketListAtom.reportWrite(value, super.bucketList, () {
      super.bucketList = value;
    });
  }

  late final _$filteredBucketListAtom =
      Atom(name: '_UserStore.filteredBucketList', context: context);

  @override
  List<Bucket> get filteredBucketList {
    _$filteredBucketListAtom.reportRead();
    return super.filteredBucketList;
  }

  @override
  set filteredBucketList(List<Bucket> value) {
    _$filteredBucketListAtom.reportWrite(value, super.filteredBucketList, () {
      super.filteredBucketList = value;
    });
  }

  late final _$getUserNicknameAsyncAction =
      AsyncAction('_UserStore.getUserNickname', context: context);

  @override
  Future<void> getUserNickname() {
    return _$getUserNicknameAsyncAction.run(() => super.getUserNickname());
  }

  late final _$getCategoriesAsyncAction =
      AsyncAction('_UserStore.getCategories', context: context);

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  late final _$getBucketListAsyncAction =
      AsyncAction('_UserStore.getBucketList', context: context);

  @override
  Future<void> getBucketList() {
    return _$getBucketListAsyncAction.run(() => super.getBucketList());
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
  void filterBucketList(String category, int status) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.filterBucketList');
    try {
      return super.filterBucketList(category, status);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nickname: ${nickname},
categories: ${categories},
bucketList: ${bucketList},
filteredBucketList: ${filteredBucketList}
    ''';
  }
}
