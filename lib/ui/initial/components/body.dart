import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/widgets/default_checkbox_listtile_with_subtitle.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndex = 0; // Add this line

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: 56.h,
          left: 34.w,
          right: 34.w,
          bottom: 14.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "공유하는 버킷리스트",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlack,
              ),
            ),
            SizedBox(height: 5.h),
            AutoSizeText(
              "위버와 함께해요",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlack,
              ),
            ),
            SizedBox(height: 40.h),
            Flexible(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    "assets/images/swiper_image_${index + 1}.png",
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                autoplayDelay: 2000,
                onIndexChanged: (value) => setState(() {
                  selectedIndex = value;
                }),
                itemCount: 4,
              ),
            ),
            SizedBox(height: 34.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: selectedIndex == i ? 20.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: selectedIndex == i
                          ? AppColors.primary2
                          : AppColors.sub1,
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 56.h),
            DefaultFlatButton(
              onPressed: () {
                context.router.replace(const SetNicknameRoute());
              },
              child: AutoSizeText(
                "시작하기",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
