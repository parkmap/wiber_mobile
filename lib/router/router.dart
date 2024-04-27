import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: InitialRoute.page),
        AutoRoute(page: SetNicknameRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SetProfileRoute.page),
        AutoRoute(page: BucketRoute.page),
        AutoRoute(page: BucketDetailRoute.page),
      ];
}
