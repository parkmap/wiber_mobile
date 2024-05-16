// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeUIStore on _HomeUIStore, Store {
  Computed<bool>? _$canEditCategoryNameComputed;

  @override
  bool get canEditCategoryName => (_$canEditCategoryNameComputed ??=
          Computed<bool>(() => super.canEditCategoryName,
              name: '_HomeUIStore.canEditCategoryName'))
      .value;

  late final _$selectedTabIndexAtom =
      Atom(name: '_HomeUIStore.selectedTabIndex', context: context);

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
      Atom(name: '_HomeUIStore.selectedCategoryIndex', context: context);

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

  late final _$wiberSpaceTitleAtom =
      Atom(name: '_HomeUIStore.wiberSpaceTitle', context: context);

  @override
  String get wiberSpaceTitle {
    _$wiberSpaceTitleAtom.reportRead();
    return super.wiberSpaceTitle;
  }

  @override
  set wiberSpaceTitle(String value) {
    _$wiberSpaceTitleAtom.reportWrite(value, super.wiberSpaceTitle, () {
      super.wiberSpaceTitle = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_HomeUIStore.selectedCategory', context: context);

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
      Atom(name: '_HomeUIStore.editingCategoryName', context: context);

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

  late final _$_HomeUIStoreActionController =
      ActionController(name: '_HomeUIStore', context: context);

  @override
  void setSelectedTabIndex(int val) {
    final _$actionInfo = _$_HomeUIStoreActionController.startAction(
        name: '_HomeUIStore.setSelectedTabIndex');
    try {
      return super.setSelectedTabIndex(val);
    } finally {
      _$_HomeUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategoryIndex(int val) {
    final _$actionInfo = _$_HomeUIStoreActionController.startAction(
        name: '_HomeUIStore.setSelectedCategoryIndex');
    try {
      return super.setSelectedCategoryIndex(val);
    } finally {
      _$_HomeUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(String val) {
    final _$actionInfo = _$_HomeUIStoreActionController.startAction(
        name: '_HomeUIStore.setSelectedCategory');
    try {
      return super.setSelectedCategory(val);
    } finally {
      _$_HomeUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditingCategoryName(String val) {
    final _$actionInfo = _$_HomeUIStoreActionController.startAction(
        name: '_HomeUIStore.setEditingCategoryName');
    try {
      return super.setEditingCategoryName(val);
    } finally {
      _$_HomeUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWiberSpaceTitle(String val) {
    final _$actionInfo = _$_HomeUIStoreActionController.startAction(
        name: '_HomeUIStore.setWiberSpaceTitle');
    try {
      return super.setWiberSpaceTitle(val);
    } finally {
      _$_HomeUIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTabIndex: ${selectedTabIndex},
selectedCategoryIndex: ${selectedCategoryIndex},
wiberSpaceTitle: ${wiberSpaceTitle},
selectedCategory: ${selectedCategory},
editingCategoryName: ${editingCategoryName},
canEditCategoryName: ${canEditCategoryName}
    ''';
  }
}
