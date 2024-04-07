import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/data/repositories/repository.dart';
import 'package:wiber_mobile/data/repositories/user_repository.dart';
import 'package:wiber_mobile/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/router/router.dart';
import 'package:wiber_mobile/stores/theme/theme_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
// import '../constants/colors.dart';
// import '../router/router.gr.dart';
// import '../utils/device_utils.dart';

class MyApp extends StatefulWidget {
  final String? pushToken;

  MyApp({
    Key? key,
    this.pushToken,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  late ThemeStore _themeStore;
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();

    _themeStore = ThemeStore(getIt<Repository>());
    _userStore = UserStore(getIt<UserRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>.value(value: _themeStore),
        Provider<UserStore>.value(value: _userStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return ScreenUtilInit(
            designSize: const Size(375, 734),
            builder: (_, child) {
              return MaterialApp.router(
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                builder: EasyLoading.init(
                  builder: (context, extendedNav) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                      child: GestureDetector(
                        onTap: () {
                          // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
                          // if (Platform.isIOS || Platform.isAndroid) {
                          // DeviceUtils.hideKeyboard(context);
                          // }
                        },
                        child: extendedNav,
                      ),
                    );
                  },
                ),
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.dark,
                darkTheme: ThemeData(
                  fontFamily: 'Pretendard',
                  scaffoldBackgroundColor: Colors.white,
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
