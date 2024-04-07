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
          children: [
            _buildTopbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopbar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/wiber_logo.png',
            width: 72.w,
            height: 14.h,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/add_person_icon.png',
                  width: 24.w,
                  height: 21.h,
                ),
              ),
              SizedBox(width: 7.w),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/notification_icon.png',
                  width: 19.25.w,
                  height: 19.5.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNickname() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            AutoSizeText(
              "",
            ),
          ],
        ),
      ),
    );
  }
}
