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
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'data/dio_client.dart' as _i8;
import 'data/network/apis/user_api.dart' as _i11;
import 'data/repositories/repository.dart' as _i9;
import 'data/repositories/user_repository.dart' as _i12;
import 'data/sharedpref/shared_preference_helper.dart' as _i7;
import 'di/network_module.dart' as _i15;
import 'di/preference_module.dart' as _i14;
import 'stores/home_ui/home_ui_store.dart' as _i4;
import 'stores/set_nickname/set_nickname_store.dart' as _i5;
import 'stores/theme/theme_store.dart' as _i10;
import 'stores/user/user_store.dart' as _i13;

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
  gh.factory<_i4.HomeUIStore>(() => _i4.HomeUIStore());
  gh.factory<_i5.SetNicknameStore>(() => _i5.SetNicknameStore());
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => preferenceModule.sharedPref,
    preResolve: true,
  );
  gh.lazySingleton<_i7.SharedPreferenceHelper>(
      () => _i7.SharedPreferenceHelper(gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i8.DioClient>(() => _i8.DioClient(
        gh<_i3.Dio>(),
        gh<_i7.SharedPreferenceHelper>(),
      ));
  gh.singleton<_i9.Repository>(
      _i9.Repository(gh<_i7.SharedPreferenceHelper>()));
  gh.factory<_i10.ThemeStore>(() => _i10.ThemeStore(gh<_i9.Repository>()));
  gh.lazySingleton<_i11.UserApi>(() => _i11.UserApi(gh<_i8.DioClient>()));
  gh.lazySingleton<_i12.UserRepository>(() => _i12.UserRepository(
        gh<_i11.UserApi>(),
        gh<_i7.SharedPreferenceHelper>(),
      ));
  gh.factory<_i13.UserStore>(() => _i13.UserStore(gh<_i12.UserRepository>()));
  return getIt;
}

class _$PreferenceModule extends _i14.PreferenceModule {}

class _$NetworkModule extends _i15.NetworkModule {}
