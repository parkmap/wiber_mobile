// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:wiber_mobile/models/bucket/bucket.dart' as _i16;
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart' as _i15;
import 'package:wiber_mobile/ui/bucket/bucket_screen.dart' as _i1;
import 'package:wiber_mobile/ui/bucket_detail/bucket_detail_screen.dart' as _i2;
import 'package:wiber_mobile/ui/bucket_participants/bucket_participants_screen.dart'
    as _i12;
import 'package:wiber_mobile/ui/home/home_screen.dart' as _i3;
import 'package:wiber_mobile/ui/initial/initial_screen.dart' as _i4;
import 'package:wiber_mobile/ui/set_nickname/set_nickname_screen.dart' as _i9;
import 'package:wiber_mobile/ui/set_profile/set_profile_screen.dart' as _i10;
import 'package:wiber_mobile/ui/setting/setting_screen.dart' as _i5;
import 'package:wiber_mobile/ui/setting_announce/setting_announce_screen.dart'
    as _i6;
import 'package:wiber_mobile/ui/setting_faq/setting_faq_screen.dart' as _i7;
import 'package:wiber_mobile/ui/setting_wiber_space/setting_wiber_space_screen.dart'
    as _i8;
import 'package:wiber_mobile/ui/splash/splash_screen.dart' as _i11;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    BucketRoute.name: (routeData) {
      final args = routeData.argsAs<BucketRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BucketScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
    BucketDetailRoute.name: (routeData) {
      final args = routeData.argsAs<BucketDetailRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BucketDetailScreen(
          key: args.key,
          space: args.space,
          item: args.item,
          onDelete: args.onDelete,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.InitialScreen(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingScreen(),
      );
    },
    SettingAnnounceRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SettingAnnounceScreen(),
      );
    },
    SettingFaqRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingFaqScreen(),
      );
    },
    SettingWiberSpaceRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingWiberSpaceScreen(),
      );
    },
    SetNicknameRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SetNicknameScreen(),
      );
    },
    SetProfileRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SetProfileScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SplashScreen(),
      );
    },
    BucketParticipantsRoute.name: (routeData) {
      final args = routeData.argsAs<BucketParticipantsRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.BucketParticipantsScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BucketScreen]
class BucketRoute extends _i13.PageRouteInfo<BucketRouteArgs> {
  BucketRoute({
    _i14.Key? key,
    required _i15.WiberSpace item,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          BucketRoute.name,
          args: BucketRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'BucketRoute';

  static const _i13.PageInfo<BucketRouteArgs> page =
      _i13.PageInfo<BucketRouteArgs>(name);
}

class BucketRouteArgs {
  const BucketRouteArgs({
    this.key,
    required this.item,
  });

  final _i14.Key? key;

  final _i15.WiberSpace item;

  @override
  String toString() {
    return 'BucketRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i2.BucketDetailScreen]
class BucketDetailRoute extends _i13.PageRouteInfo<BucketDetailRouteArgs> {
  BucketDetailRoute({
    _i14.Key? key,
    required _i15.WiberSpace space,
    required _i16.Bucket item,
    required void Function() onDelete,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          BucketDetailRoute.name,
          args: BucketDetailRouteArgs(
            key: key,
            space: space,
            item: item,
            onDelete: onDelete,
          ),
          initialChildren: children,
        );

  static const String name = 'BucketDetailRoute';

  static const _i13.PageInfo<BucketDetailRouteArgs> page =
      _i13.PageInfo<BucketDetailRouteArgs>(name);
}

class BucketDetailRouteArgs {
  const BucketDetailRouteArgs({
    this.key,
    required this.space,
    required this.item,
    required this.onDelete,
  });

  final _i14.Key? key;

  final _i15.WiberSpace space;

  final _i16.Bucket item;

  final void Function() onDelete;

  @override
  String toString() {
    return 'BucketDetailRouteArgs{key: $key, space: $space, item: $item, onDelete: $onDelete}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i13.PageRouteInfo<void> {
  const InitialRoute({List<_i13.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SettingScreen]
class SettingRoute extends _i13.PageRouteInfo<void> {
  const SettingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SettingAnnounceScreen]
class SettingAnnounceRoute extends _i13.PageRouteInfo<void> {
  const SettingAnnounceRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingAnnounceRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingAnnounceRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingFaqScreen]
class SettingFaqRoute extends _i13.PageRouteInfo<void> {
  const SettingFaqRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingFaqRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingFaqRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingWiberSpaceScreen]
class SettingWiberSpaceRoute extends _i13.PageRouteInfo<void> {
  const SettingWiberSpaceRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingWiberSpaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingWiberSpaceRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SetNicknameScreen]
class SetNicknameRoute extends _i13.PageRouteInfo<void> {
  const SetNicknameRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SetNicknameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetNicknameRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SetProfileScreen]
class SetProfileRoute extends _i13.PageRouteInfo<void> {
  const SetProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SetProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetProfileRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.BucketParticipantsScreen]
class BucketParticipantsRoute
    extends _i13.PageRouteInfo<BucketParticipantsRouteArgs> {
  BucketParticipantsRoute({
    _i14.Key? key,
    required _i15.WiberSpace item,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          BucketParticipantsRoute.name,
          args: BucketParticipantsRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'BucketParticipantsRoute';

  static const _i13.PageInfo<BucketParticipantsRouteArgs> page =
      _i13.PageInfo<BucketParticipantsRouteArgs>(name);
}

class BucketParticipantsRouteArgs {
  const BucketParticipantsRouteArgs({
    this.key,
    required this.item,
  });

  final _i14.Key? key;

  final _i15.WiberSpace item;

  @override
  String toString() {
    return 'BucketParticipantsRouteArgs{key: $key, item: $item}';
  }
}
