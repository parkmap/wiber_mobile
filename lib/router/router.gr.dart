// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart' as _i9;
import 'package:wiber_mobile/ui/bucket/bucket_screen.dart' as _i1;
import 'package:wiber_mobile/ui/home/home_screen.dart' as _i2;
import 'package:wiber_mobile/ui/initial/initial_screen.dart' as _i3;
import 'package:wiber_mobile/ui/set_nickname/set_nickname_screen.dart' as _i4;
import 'package:wiber_mobile/ui/set_profile/set_profile_screen.dart' as _i5;
import 'package:wiber_mobile/ui/splash/splash_screen.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    BucketRoute.name: (routeData) {
      final args = routeData.argsAs<BucketRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BucketScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InitialScreen(),
      );
    },
    SetNicknameRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SetNicknameScreen(),
      );
    },
    SetProfileRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SetProfileScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BucketScreen]
class BucketRoute extends _i7.PageRouteInfo<BucketRouteArgs> {
  BucketRoute({
    _i8.Key? key,
    required _i9.WiberSpace item,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          BucketRoute.name,
          args: BucketRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'BucketRoute';

  static const _i7.PageInfo<BucketRouteArgs> page =
      _i7.PageInfo<BucketRouteArgs>(name);
}

class BucketRouteArgs {
  const BucketRouteArgs({
    this.key,
    required this.item,
  });

  final _i8.Key? key;

  final _i9.WiberSpace item;

  @override
  String toString() {
    return 'BucketRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.InitialScreen]
class InitialRoute extends _i7.PageRouteInfo<void> {
  const InitialRoute({List<_i7.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SetNicknameScreen]
class SetNicknameRoute extends _i7.PageRouteInfo<void> {
  const SetNicknameRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SetNicknameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetNicknameRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SetProfileScreen]
class SetProfileRoute extends _i7.PageRouteInfo<void> {
  const SetProfileRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SetProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetProfileRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
