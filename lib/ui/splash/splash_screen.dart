import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/constants/textStyle.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Timer(
      const Duration(milliseconds: 1500),
      () async {
        context.router.replace(const InitialRoute());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.mainBlack,
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
                SizedBox(height: 22.h),
                AutoSizeText(
                  "우리만의 버킷리스트, 위버",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tertiaryBlack,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
