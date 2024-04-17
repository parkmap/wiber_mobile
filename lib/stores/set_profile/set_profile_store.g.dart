// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SetProfileStore on _SetProfileStore, Store {
  late final _$profileImageAtom =
      Atom(name: '_SetProfileStore.profileImage', context: context);

  @override
  XFile? get profileImage {
    _$profileImageAtom.reportRead();
    return super.profileImage;
  }

  @override
  set profileImage(XFile? value) {
    _$profileImageAtom.reportWrite(value, super.profileImage, () {
      super.profileImage = value;
    });
  }

  late final _$_SetProfileStoreActionController =
      ActionController(name: '_SetProfileStore', context: context);

  @override
  void setProfileImage(XFile val) {
    final _$actionInfo = _$_SetProfileStoreActionController.startAction(
        name: '_SetProfileStore.setProfileImage');
    try {
      return super.setProfileImage(val);
    } finally {
      _$_SetProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetProfileImage() {
    final _$actionInfo = _$_SetProfileStoreActionController.startAction(
        name: '_SetProfileStore.resetProfileImage');
    try {
      return super.resetProfileImage();
    } finally {
      _$_SetProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileImage: ${profileImage}
    ''';
  }
}
