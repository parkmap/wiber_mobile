import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserStore? _userStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
    }

    Timer(
      const Duration(milliseconds: 1500),
      () async {
        if (_userStore?.getAuthToken() == null) {
          context.router.replace(const InitialRoute());
        } else {
          context.router.replace(const HomeRoute());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/wiber_logo.png',
                  width: 103.w,
                  height: 20.h,
                ),
                // SizedBox(height: 22.h),
                // AutoSizeText(
                //   "우리만의 버킷리스트, 위버",
                //   style: TextStyle(
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w400,
                //     color: AppColors.tertiaryBlack,
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
