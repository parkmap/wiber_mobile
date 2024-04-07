// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:wiber_mobile/ui/initial/initial_screen.dart' as _i2;
import 'package:wiber_mobile/ui/set_nickname/initial_screen.dart' as _i3;
import 'package:wiber_mobile/ui/splash/splash_screen.dart' as _i1;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.InitialScreen(),
      );
    },
    SetNicknameRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SetNicknameScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.InitialScreen]
class InitialRoute extends _i4.PageRouteInfo<void> {
  const InitialRoute({List<_i4.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SetNicknameScreen]
class SetNicknameRoute extends _i4.PageRouteInfo<void> {
  const SetNicknameRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SetNicknameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetNicknameRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
