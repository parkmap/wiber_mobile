import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/setting_ui/setting_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  SettingUiStore _uiStore = SettingUiStore();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nicknameController = TextEditingController();
  late FocusNode _nicknameFocusNode;

  @override
  void initState() {
    _uiStore = SettingUiStore();
    _nicknameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
    }

    _nicknameController.text = _userStore!.user!.nickname;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) => Column(
          children: [
            _buildTopBar(),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.gray20,
            ),
            _buildItems(
              title: "위버 운영정책 변경 안내",
              createdAt: "2024.01.17",
              onTap: () {},
            ),
            _buildItems(
              title: "개인정보처리방침 변경 안내",
              createdAt: "2024.01.17",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.only(
        top: 14.h,
        bottom: 14.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    context.router.pop();
                  },
                  child: Image.asset(
                    'assets/icons/chevron_left_icon.png',
                    width: 20.w,
                    height: 15.h,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "공지사항",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItems({
    required String title,
    required Function onTap,
    required String createdAt,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Image.asset(
                "assets/icons/setting_announce_item_icon.png",
                width: 18.w,
                height: 16.h,
              ),
            ),
            SizedBox(width: 17.w),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      AutoSizeText(
                        createdAt,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.tertiaryBlack,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/icons/chevron_right_icon.png",
                    width: 10.w,
                    height: 12.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
