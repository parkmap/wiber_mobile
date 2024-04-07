import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  int selectedIndex = -1; // Add this line

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 100.h),
                Image.asset(
                  'assets/images/wiber_landing_image.png',
                  width: 129.w,
                  height: 129.h,
                ),
                SizedBox(height: 43.h),
                AutoSizeText(
                  "반가워요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray90,
                  ),
                ),
                SizedBox(height: 5.h),
                AutoSizeText(
                  "우리만의 버킷리스트를 만들어볼까요?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray90,
                  ),
                ),
                SizedBox(height: 16.h),
                DefaultCheckboxListTileWithSubtitle(
                  checkboxValue: false,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  isChecked: selectedIndex == 0,
                  title: "영어공부하기",
                  subTitle: "내년까지 프리토킹이 가능할 수 있도록!",
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: AppColors.gray70,
                    size: 16.sp,
                  ),
                ),
                DefaultCheckboxListTileWithSubtitle(
                  checkboxValue: false,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  isChecked: selectedIndex == 1,
                  title: "영자신문 보기",
                  subTitle: "일주일에 7개씩 스크랩",
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: AppColors.gray70,
                    size: 16.sp,
                  ),
                ),
                DefaultCheckboxListTileWithSubtitle(
                  checkboxValue: false,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  isChecked: selectedIndex == 2,
                  title: "영어단어 외우기",
                  subTitle: "토익단어 700개",
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: AppColors.gray70,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
            DefaultFlatButton(
              onPressed: selectedIndex < 0
                  ? null
                  : () {
                      context.router.push(const SetNicknameRoute());
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
