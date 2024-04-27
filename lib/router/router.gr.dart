// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:wiber_mobile/models/bucket/bucket.dart' as _i11;
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart' as _i10;
import 'package:wiber_mobile/ui/bucket/bucket_screen.dart' as _i1;
import 'package:wiber_mobile/ui/bucket_detail/bucket_detail_screen.dart' as _i7;
import 'package:wiber_mobile/ui/home/home_screen.dart' as _i2;
import 'package:wiber_mobile/ui/initial/initial_screen.dart' as _i3;
import 'package:wiber_mobile/ui/set_nickname/set_nickname_screen.dart' as _i4;
import 'package:wiber_mobile/ui/set_profile/set_profile_screen.dart' as _i5;
import 'package:wiber_mobile/ui/splash/splash_screen.dart' as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    BucketRoute.name: (routeData) {
      final args = routeData.argsAs<BucketRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BucketScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InitialScreen(),
      );
    },
    SetNicknameRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SetNicknameScreen(),
      );
    },
    SetProfileRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SetProfileScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SplashScreen(),
      );
    },
    BucketDetailRoute.name: (routeData) {
      final args = routeData.argsAs<BucketDetailRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.BucketDetailScreen(
          key: args.key,
          space: args.space,
          item: args.item,
          onDelete: args.onDelete,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BucketScreen]
class BucketRoute extends _i8.PageRouteInfo<BucketRouteArgs> {
  BucketRoute({
    _i9.Key? key,
    required _i10.WiberSpace item,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BucketRoute.name,
          args: BucketRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'BucketRoute';

  static const _i8.PageInfo<BucketRouteArgs> page =
      _i8.PageInfo<BucketRouteArgs>(name);
}

class BucketRouteArgs {
  const BucketRouteArgs({
    this.key,
    required this.item,
  });

  final _i9.Key? key;

  final _i10.WiberSpace item;

  @override
  String toString() {
    return 'BucketRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.InitialScreen]
class InitialRoute extends _i8.PageRouteInfo<void> {
  const InitialRoute({List<_i8.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SetNicknameScreen]
class SetNicknameRoute extends _i8.PageRouteInfo<void> {
  const SetNicknameRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SetNicknameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetNicknameRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SetProfileScreen]
class SetProfileRoute extends _i8.PageRouteInfo<void> {
  const SetProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SetProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetProfileRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.BucketDetailScreen]
class BucketDetailRoute extends _i8.PageRouteInfo<BucketDetailRouteArgs> {
  BucketDetailRoute({
    _i9.Key? key,
    required _i10.WiberSpace space,
    required _i11.Bucket item,
    required void Function() onDelete,
    List<_i8.PageRouteInfo>? children,
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

  static const _i8.PageInfo<BucketDetailRouteArgs> page =
      _i8.PageInfo<BucketDetailRouteArgs>(name);
}

class BucketDetailRouteArgs {
  const BucketDetailRouteArgs({
    this.key,
    required this.space,
    required this.item,
    required this.onDelete,
  });

  final _i9.Key? key;

  final _i10.WiberSpace space;

  final _i11.Bucket item;

  final void Function() onDelete;

  @override
  String toString() {
    return 'BucketDetailRouteArgs{key: $key, space: $space, item: $item, onDelete: $onDelete}';
  }
}
