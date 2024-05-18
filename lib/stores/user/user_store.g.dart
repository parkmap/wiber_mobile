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
  List<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<Category> value) {
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

  late final _$isLoadingWiberspaceAtom =
      Atom(name: '_UserStore.isLoadingWiberspace', context: context);

  @override
  bool get isLoadingWiberspace {
    _$isLoadingWiberspaceAtom.reportRead();
    return super.isLoadingWiberspace;
  }

  @override
  set isLoadingWiberspace(bool value) {
    _$isLoadingWiberspaceAtom.reportWrite(value, super.isLoadingWiberspace, () {
      super.isLoadingWiberspace = value;
    });
  }

  late final _$isLoadingBucketAtom =
      Atom(name: '_UserStore.isLoadingBucket', context: context);

  @override
  bool get isLoadingBucket {
    _$isLoadingBucketAtom.reportRead();
    return super.isLoadingBucket;
  }

  @override
  set isLoadingBucket(bool value) {
    _$isLoadingBucketAtom.reportWrite(value, super.isLoadingBucket, () {
      super.isLoadingBucket = value;
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

  late final _$logoutAsyncAction =
      AsyncAction('_UserStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_UserStore.getUserInfo', context: context);

  @override
  Future<void> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  late final _$refreshUserInfoAsyncAction =
      AsyncAction('_UserStore.refreshUserInfo', context: context);

  @override
  Future<void> refreshUserInfo() {
    return _$refreshUserInfoAsyncAction.run(() => super.refreshUserInfo());
  }

  late final _$updateUserInfoAsyncAction =
      AsyncAction('_UserStore.updateUserInfo', context: context);

  @override
  Future<dynamic> updateUserInfo(
      {required String userNickname, required String pushToken}) {
    return _$updateUserInfoAsyncAction.run(() =>
        super.updateUserInfo(userNickname: userNickname, pushToken: pushToken));
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
  Future<dynamic> saveProfileImage({required Uint8List profileImage}) {
    return _$saveProfileImageAsyncAction
        .run(() => super.saveProfileImage(profileImage: profileImage));
  }

  late final _$saveUserIdAsyncAction =
      AsyncAction('_UserStore.saveUserId', context: context);

  @override
  Future<void> saveUserId({required String userId}) {
    return _$saveUserIdAsyncAction.run(() => super.saveUserId(userId: userId));
  }

  late final _$getWiberSpaceListAsyncAction =
      AsyncAction('_UserStore.getWiberSpaceList', context: context);

  @override
  Future<void> getWiberSpaceList() {
    return _$getWiberSpaceListAsyncAction.run(() => super.getWiberSpaceList());
  }

  late final _$createWiberSpaceAsyncAction =
      AsyncAction('_UserStore.createWiberSpace', context: context);

  @override
  Future<dynamic> createWiberSpace({required String title}) {
    return _$createWiberSpaceAsyncAction
        .run(() => super.createWiberSpace(title: title));
  }

  late final _$updateWiberSpaceAsyncAction =
      AsyncAction('_UserStore.updateWiberSpace', context: context);

  @override
  Future<dynamic> updateWiberSpace(
      {required String spaceId, required String title}) {
    return _$updateWiberSpaceAsyncAction
        .run(() => super.updateWiberSpace(spaceId: spaceId, title: title));
  }

  late final _$deleteWiberSpaceAsyncAction =
      AsyncAction('_UserStore.deleteWiberSpace', context: context);

  @override
  Future<dynamic> deleteWiberSpace({required String spaceId}) {
    return _$deleteWiberSpaceAsyncAction
        .run(() => super.deleteWiberSpace(spaceId: spaceId));
  }

  late final _$getCategoryListAsyncAction =
      AsyncAction('_UserStore.getCategoryList', context: context);

  @override
  Future<void> getCategoryList({required String spaceId}) {
    return _$getCategoryListAsyncAction
        .run(() => super.getCategoryList(spaceId: spaceId));
  }

  late final _$createCategoryAsyncAction =
      AsyncAction('_UserStore.createCategory', context: context);

  @override
  Future<dynamic> createCategory(
      {required String spaceId, required String title}) {
    return _$createCategoryAsyncAction
        .run(() => super.createCategory(spaceId: spaceId, title: title));
  }

  late final _$updateCategoryAsyncAction =
      AsyncAction('_UserStore.updateCategory', context: context);

  @override
  Future<dynamic> updateCategory(
      {required String spaceId,
      required String categoryId,
      required String title}) {
    return _$updateCategoryAsyncAction.run(() => super.updateCategory(
        spaceId: spaceId, categoryId: categoryId, title: title));
  }

  late final _$deleteCategoryAsyncAction =
      AsyncAction('_UserStore.deleteCategory', context: context);

  @override
  Future<dynamic> deleteCategory(
      {required String spaceId, required String categoryId}) {
    return _$deleteCategoryAsyncAction.run(
        () => super.deleteCategory(spaceId: spaceId, categoryId: categoryId));
  }

  late final _$getBucketListAsyncAction =
      AsyncAction('_UserStore.getBucketList', context: context);

  @override
  Future<void> getBucketList(
      {required String spaceId, String? categoryId, int? state}) {
    return _$getBucketListAsyncAction.run(() => super
        .getBucketList(spaceId: spaceId, categoryId: categoryId, state: state));
  }

  late final _$createBucketAsyncAction =
      AsyncAction('_UserStore.createBucket', context: context);

  @override
  Future<dynamic> createBucket(
      {required String spaceId,
      required String categoryId,
      required String title,
      required String content,
      required String state,
      required String date}) {
    return _$createBucketAsyncAction.run(() => super.createBucket(
        spaceId: spaceId,
        categoryId: categoryId,
        title: title,
        content: content,
        state: state,
        date: date));
  }

  late final _$updateBucketAsyncAction =
      AsyncAction('_UserStore.updateBucket', context: context);

  @override
  Future<dynamic> updateBucket(
      {required String spaceId,
      required String categoryId,
      required String bucketId,
      String? state,
      String? date,
      required String title,
      required String content}) {
    return _$updateBucketAsyncAction.run(() => super.updateBucket(
        spaceId: spaceId,
        categoryId: categoryId,
        bucketId: bucketId,
        state: state,
        date: date,
        title: title,
        content: content));
  }

  late final _$deleteBucketAsyncAction =
      AsyncAction('_UserStore.deleteBucket', context: context);

  @override
  Future<dynamic> deleteBucket(
      {required String spaceId, required String bucketId}) {
    return _$deleteBucketAsyncAction
        .run(() => super.deleteBucket(spaceId: spaceId, bucketId: bucketId));
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
  String? getUserId() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.getUserId');
    try {
      return super.getUserId();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterBucketList({required String categoryId, required int status}) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.filterBucketList');
    try {
      return super.filterBucketList(categoryId: categoryId, status: status);
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
isLoadingWiberspace: ${isLoadingWiberspace},
isLoadingBucket: ${isLoadingBucket},
user: ${user}
    ''';
  }
}
