// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import 'data/dio_client.dart' as _i11;
import 'data/network/apis/user_api.dart' as _i14;
import 'data/repositories/repository.dart' as _i12;
import 'data/repositories/user_repository.dart' as _i15;
import 'data/sharedpref/shared_preference_helper.dart' as _i10;
import 'di/network_module.dart' as _i17;
import 'di/preference_module.dart' as _i18;
import 'stores/bucket_ui/bucket_ui_store.dart' as _i3;
import 'stores/home_ui/home_ui_store.dart' as _i5;
import 'stores/set_nickname/set_nickname_store.dart' as _i6;
import 'stores/set_profile/set_profile_store.dart' as _i7;
import 'stores/setting_ui/setting_ui_store.dart' as _i8;
import 'stores/theme/theme_store.dart' as _i13;
import 'stores/user/user_store.dart' as _i16;

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
  gh.factory<_i3.BucketUIStore>(() => _i3.BucketUIStore());
  gh.lazySingleton<_i4.Dio>(() => networkModule.dio);
  gh.factory<_i5.HomeUIStore>(() => _i5.HomeUIStore());
  gh.factory<_i6.SetNicknameStore>(() => _i6.SetNicknameStore());
  gh.factory<_i7.SetProfileStore>(() => _i7.SetProfileStore());
  gh.factory<_i8.SettingUiStore>(() => _i8.SettingUiStore());
  await gh.singletonAsync<_i9.SharedPreferences>(
    () => preferenceModule.sharedPref,
    preResolve: true,
  );
  gh.lazySingleton<_i10.SharedPreferenceHelper>(
      () => _i10.SharedPreferenceHelper(gh<_i9.SharedPreferences>()));
  gh.lazySingleton<_i11.DioClient>(() => _i11.DioClient(
        gh<_i4.Dio>(),
        gh<_i10.SharedPreferenceHelper>(),
      ));
  gh.singleton<_i12.Repository>(
      () => _i12.Repository(gh<_i10.SharedPreferenceHelper>()));
  gh.factory<_i13.ThemeStore>(() => _i13.ThemeStore(gh<_i12.Repository>()));
  gh.lazySingleton<_i14.UserApi>(() => _i14.UserApi(
        gh<_i11.DioClient>(),
        gh<_i4.Dio>(),
      ));
  gh.lazySingleton<_i15.UserRepository>(() => _i15.UserRepository(
        gh<_i14.UserApi>(),
        gh<_i10.SharedPreferenceHelper>(),
      ));
  gh.factory<_i16.UserStore>(() => _i16.UserStore(gh<_i15.UserRepository>()));
  return getIt;
}

class _$NetworkModule extends _i17.NetworkModule {}

class _$PreferenceModule extends _i18.PreferenceModule {}
