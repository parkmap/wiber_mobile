// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$wiberListAtom =
      Atom(name: '_UserStore.wiberList', context: context);

  @override
  List<dynamic> get wiberList {
    _$wiberListAtom.reportRead();
    return super.wiberList;
  }

  @override
  set wiberList(List<dynamic> value) {
    _$wiberListAtom.reportWrite(value, super.wiberList, () {
      super.wiberList = value;
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

  late final _$wiberSpaceListAtom =
      Atom(name: '_UserStore.wiberSpaceList', context: context);

  @override
  List<WiberSpace> get wiberSpaceList {
    _$wiberSpaceListAtom.reportRead();
    return super.wiberSpaceList;
  }

  @override
  set wiberSpaceList(List<WiberSpace> value) {
    _$wiberSpaceListAtom.reportWrite(value, super.wiberSpaceList, () {
      super.wiberSpaceList = value;
    });
  }

  late final _$isCreatingUserAtom =
      Atom(name: '_UserStore.isCreatingUser', context: context);

  @override
  bool get isCreatingUser {
    _$isCreatingUserAtom.reportRead();
    return super.isCreatingUser;
  }

  @override
  set isCreatingUser(bool value) {
    _$isCreatingUserAtom.reportWrite(value, super.isCreatingUser, () {
      super.isCreatingUser = value;
    });
  }

  late final _$userAtom = Atom(name: '_UserStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$saveUuidAsyncAction =
      AsyncAction('_UserStore.saveUuid', context: context);

  @override
  Future<bool?> saveUuid() {
    return _$saveUuidAsyncAction.run(() => super.saveUuid());
  }

  late final _$createUserAsyncAction =
      AsyncAction('_UserStore.createUser', context: context);

  @override
  Future<dynamic> createUser({required String username}) {
    return _$createUserAsyncAction
        .run(() => super.createUser(username: username));
  }

  late final _$saveProfileImageAsyncAction =
      AsyncAction('_UserStore.saveProfileImage', context: context);

  @override
  Future<dynamic> saveProfileImage({required MultipartFile profileImage}) {
    return _$saveProfileImageAsyncAction
        .run(() => super.saveProfileImage(profileImage: profileImage));
  }

  late final _$saveUserIdAsyncAction =
      AsyncAction('_UserStore.saveUserId', context: context);

  @override
  Future<void> saveUserId({required String userId}) {
    return _$saveUserIdAsyncAction.run(() => super.saveUserId(userId: userId));
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

  late final _$getUserInfoAsyncAction =
      AsyncAction('_UserStore.getUserInfo', context: context);

  @override
  Future<void> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  late final _$getWiberSpaceListByUserAsyncAction =
      AsyncAction('_UserStore.getWiberSpaceListByUser', context: context);

  @override
  Future<void> getWiberSpaceListByUser() {
    return _$getWiberSpaceListByUserAsyncAction
        .run(() => super.getWiberSpaceListByUser());
  }

  late final _$getUserInfoAndWiberSpaceListAsyncAction =
      AsyncAction('_UserStore.getUserInfoAndWiberSpaceList', context: context);

  @override
  Future<void> getUserInfoAndWiberSpaceList() {
    return _$getUserInfoAndWiberSpaceListAsyncAction
        .run(() => super.getUserInfoAndWiberSpaceList());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  String? getUuid() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.getUuid');
    try {
      return super.getUuid();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

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
wiberList: ${wiberList},
categories: ${categories},
bucketList: ${bucketList},
filteredBucketList: ${filteredBucketList},
wiberSpaceList: ${wiberSpaceList},
isCreatingUser: ${isCreatingUser},
user: ${user}
    ''';
  }
}
