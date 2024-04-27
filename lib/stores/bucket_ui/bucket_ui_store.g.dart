// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BucketUIStore on _BucketUIStore, Store {
  Computed<bool>? _$canEditCategoryNameComputed;

  @override
  bool get canEditCategoryName => (_$canEditCategoryNameComputed ??=
          Computed<bool>(() => super.canEditCategoryName,
              name: '_BucketUIStore.canEditCategoryName'))
      .value;

  late final _$selectedTabIndexAtom =
      Atom(name: '_BucketUIStore.selectedTabIndex', context: context);

  @override
  int get selectedTabIndex {
    _$selectedTabIndexAtom.reportRead();
    return super.selectedTabIndex;
  }

  @override
  set selectedTabIndex(int value) {
    _$selectedTabIndexAtom.reportWrite(value, super.selectedTabIndex, () {
      super.selectedTabIndex = value;
    });
  }

  late final _$selectedCategoryIndexAtom =
      Atom(name: '_BucketUIStore.selectedCategoryIndex', context: context);

  @override
  int get selectedCategoryIndex {
    _$selectedCategoryIndexAtom.reportRead();
    return super.selectedCategoryIndex;
  }

  @override
  set selectedCategoryIndex(int value) {
    _$selectedCategoryIndexAtom.reportWrite(value, super.selectedCategoryIndex,
        () {
      super.selectedCategoryIndex = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_BucketUIStore.selectedCategory', context: context);

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$editingCategoryNameAtom =
      Atom(name: '_BucketUIStore.editingCategoryName', context: context);

  @override
  String get editingCategoryName {
    _$editingCategoryNameAtom.reportRead();
    return super.editingCategoryName;
  }

  @override
  set editingCategoryName(String value) {
    _$editingCategoryNameAtom.reportWrite(value, super.editingCategoryName, () {
      super.editingCategoryName = value;
    });
  }

  late final _$newBucketNameAtom =
      Atom(name: '_BucketUIStore.newBucketName', context: context);

  @override
  String get newBucketName {
    _$newBucketNameAtom.reportRead();
    return super.newBucketName;
  }

  @override
  set newBucketName(String value) {
    _$newBucketNameAtom.reportWrite(value, super.newBucketName, () {
      super.newBucketName = value;
    });
  }

  late final _$newBucketDescriptionAtom =
      Atom(name: '_BucketUIStore.newBucketDescription', context: context);

  @override
  String get newBucketDescription {
    _$newBucketDescriptionAtom.reportRead();
    return super.newBucketDescription;
  }

  @override
  set newBucketDescription(String value) {
    _$newBucketDescriptionAtom.reportWrite(value, super.newBucketDescription,
        () {
      super.newBucketDescription = value;
    });
  }

  late final _$newBucketEndDateAtom =
      Atom(name: '_BucketUIStore.newBucketEndDate', context: context);

  @override
  String get newBucketEndDate {
    _$newBucketEndDateAtom.reportRead();
    return super.newBucketEndDate;
  }

  @override
  set newBucketEndDate(String value) {
    _$newBucketEndDateAtom.reportWrite(value, super.newBucketEndDate, () {
      super.newBucketEndDate = value;
    });
  }

  late final _$newBucketDetailCategoryAtom =
      Atom(name: '_BucketUIStore.newBucketDetailCategory', context: context);

  @override
  String get newBucketDetailCategory {
    _$newBucketDetailCategoryAtom.reportRead();
    return super.newBucketDetailCategory;
  }

  @override
  set newBucketDetailCategory(String value) {
    _$newBucketDetailCategoryAtom
        .reportWrite(value, super.newBucketDetailCategory, () {
      super.newBucketDetailCategory = value;
    });
  }

  late final _$createNewBucketPhaseAtom =
      Atom(name: '_BucketUIStore.createNewBucketPhase', context: context);

  @override
  int get createNewBucketPhase {
    _$createNewBucketPhaseAtom.reportRead();
    return super.createNewBucketPhase;
  }

  @override
  set createNewBucketPhase(int value) {
    _$createNewBucketPhaseAtom.reportWrite(value, super.createNewBucketPhase,
        () {
      super.createNewBucketPhase = value;
    });
  }

  late final _$isEditingAtom =
      Atom(name: '_BucketUIStore.isEditing', context: context);

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  late final _$_BucketUIStoreActionController =
      ActionController(name: '_BucketUIStore', context: context);

  @override
  void setSelectedTabIndex(int val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setSelectedTabIndex');
    try {
      return super.setSelectedTabIndex(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategoryIndex(int val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setSelectedCategoryIndex');
    try {
      return super.setSelectedCategoryIndex(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setSelectedCategory');
    try {
      return super.setSelectedCategory(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditingCategoryName(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setEditingCategoryName');
    try {
      return super.setEditingCategoryName(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewBucketName(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setNewBucketName');
    try {
      return super.setNewBucketName(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewBucketDescription(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setNewBucketDescription');
    try {
      return super.setNewBucketDescription(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewBucketEndDate(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setNewBucketEndDate');
    try {
      return super.setNewBucketEndDate(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCreateNewBucketPhase(int val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setCreateNewBucketPhase');
    try {
      return super.setCreateNewBucketPhase(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewBucketDetailCategory(String val) {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.setNewBucketDetailCategory');
    try {
      return super.setNewBucketDetailCategory(val);
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetNewBucketDatas() {
    final _$actionInfo = _$_BucketUIStoreActionController.startAction(
        name: '_BucketUIStore.resetNewBucketDatas');
    try {
      return super.resetNewBucketDatas();
    } finally {
      _$_BucketUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTabIndex: ${selectedTabIndex},
selectedCategoryIndex: ${selectedCategoryIndex},
selectedCategory: ${selectedCategory},
editingCategoryName: ${editingCategoryName},
newBucketName: ${newBucketName},
newBucketDescription: ${newBucketDescription},
newBucketEndDate: ${newBucketEndDate},
newBucketDetailCategory: ${newBucketDetailCategory},
createNewBucketPhase: ${createNewBucketPhase},
isEditing: ${isEditing},
canEditCategoryName: ${canEditCategoryName}
    ''';
  }
}
