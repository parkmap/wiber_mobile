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

import 'data/dio_client.dart' as _i7;
import 'data/network/apis/user_api.dart' as _i10;
import 'data/repositories/repository.dart' as _i8;
import 'data/repositories/user_repository.dart' as _i11;
import 'data/sharedpref/shared_preference_helper.dart' as _i6;
import 'di/network_module.dart' as _i14;
import 'di/preference_module.dart' as _i13;
import 'stores/set_nickname/set_nickname_store.dart' as _i4;
import 'stores/theme/theme_store.dart' as _i9;
import 'stores/user/user_store.dart' as _i12;

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
  gh.lazySingleton<_i7.DioClient>(() => _i7.DioClient(
        gh<_i3.Dio>(),
        gh<_i6.SharedPreferenceHelper>(),
      ));
  gh.singleton<_i8.Repository>(
      _i8.Repository(gh<_i6.SharedPreferenceHelper>()));
  gh.factory<_i9.ThemeStore>(() => _i9.ThemeStore(gh<_i8.Repository>()));
  gh.lazySingleton<_i10.UserApi>(() => _i10.UserApi(gh<_i7.DioClient>()));
  gh.lazySingleton<_i11.UserRepository>(() => _i11.UserRepository(
        gh<_i10.UserApi>(),
        gh<_i6.SharedPreferenceHelper>(),
      ));
  gh.factory<_i12.UserStore>(() => _i12.UserStore(gh<_i11.UserRepository>()));
  return getIt;
}

class _$PreferenceModule extends _i13.PreferenceModule {}

class _$NetworkModule extends _i14.NetworkModule {}
