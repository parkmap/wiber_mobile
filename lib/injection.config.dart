// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'data/repositories/repository.dart' as _i7;
import 'data/sharedpref/shared_preference_helper.dart' as _i6;
import 'di/network_module.dart' as _i10;
import 'di/preference_module.dart' as _i9;
import 'stores/set_nickname/set_nickname_store.dart' as _i4;
import 'stores/theme/theme_store.dart' as _i8;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final networkModule = _$NetworkModule();
  final preferenceModule = _$PreferenceModule();
  gh.lazySingleton<_i3.Dio>(() => networkModule.dio);
  gh.factory<_i4.SetNicknameStore>(() => _i4.SetNicknameStore());
  await gh.singletonAsync<_i5.SharedPreferences>(
    () => preferenceModule.sharedPref,
    preResolve: true,
  );
  gh.lazySingleton<_i6.SharedPreferenceHelper>(
      () => _i6.SharedPreferenceHelper(gh<_i5.SharedPreferences>()));
  gh.singleton<_i7.Repository>(
      _i7.Repository(gh<_i6.SharedPreferenceHelper>()));
  gh.factory<_i8.ThemeStore>(() => _i8.ThemeStore(gh<_i7.Repository>()));
  return getIt;
}

class _$PreferenceModule extends _i9.PreferenceModule {}

class _$NetworkModule extends _i10.NetworkModule {}
