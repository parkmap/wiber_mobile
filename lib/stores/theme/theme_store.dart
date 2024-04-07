import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/repository.dart';

part 'theme_store.g.dart';

@injectable
class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  // repository instance
  final Repository _repository;

  // store variables:-----------------------------------------------------------
  @observable
  bool _darkMode = false;

  // getters:-------------------------------------------------------------------
  bool get darkMode => _darkMode;

  // constructor:---------------------------------------------------------------
  _ThemeStore(Repository repository) : _repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeBrightnessToDark(bool value) async {
    _darkMode = value;
    await _repository.changeBrightnessToDark(value);
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    _darkMode = await _repository.isDarkMode;
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;
}
