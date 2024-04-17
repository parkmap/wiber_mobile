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
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'data/dio_client.dart' as _i9;
import 'data/network/apis/user_api.dart' as _i12;
import 'data/repositories/repository.dart' as _i10;
import 'data/repositories/user_repository.dart' as _i13;
import 'data/sharedpref/shared_preference_helper.dart' as _i8;
import 'di/network_module.dart' as _i16;
import 'di/preference_module.dart' as _i15;
import 'stores/home_ui/home_ui_store.dart' as _i4;
import 'stores/set_nickname/set_nickname_store.dart' as _i5;
import 'stores/set_profile/set_profile_store.dart' as _i6;
import 'stores/theme/theme_store.dart' as _i11;
import 'stores/user/user_store.dart' as _i14;

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
  gh.factory<_i6.SetProfileStore>(() => _i6.SetProfileStore());
  await gh.singletonAsync<_i7.SharedPreferences>(
    () => preferenceModule.sharedPref,
    preResolve: true,
  );
  gh.lazySingleton<_i8.SharedPreferenceHelper>(
      () => _i8.SharedPreferenceHelper(gh<_i7.SharedPreferences>()));
  gh.lazySingleton<_i9.DioClient>(() => _i9.DioClient(
        gh<_i3.Dio>(),
        gh<_i8.SharedPreferenceHelper>(),
      ));
  gh.singleton<_i10.Repository>(
      _i10.Repository(gh<_i8.SharedPreferenceHelper>()));
  gh.factory<_i11.ThemeStore>(() => _i11.ThemeStore(gh<_i10.Repository>()));
  gh.lazySingleton<_i12.UserApi>(() => _i12.UserApi(gh<_i9.DioClient>()));
  gh.lazySingleton<_i13.UserRepository>(() => _i13.UserRepository(
        gh<_i12.UserApi>(),
        gh<_i8.SharedPreferenceHelper>(),
      ));
  gh.factory<_i14.UserStore>(() => _i14.UserStore(gh<_i13.UserRepository>()));
  return getIt;
}

class _$PreferenceModule extends _i15.PreferenceModule {}

class _$NetworkModule extends _i16.NetworkModule {}
