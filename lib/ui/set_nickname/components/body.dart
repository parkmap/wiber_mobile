import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/set_nickname/set_nickname_store.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SetNicknameStore _setNicknameStore = SetNicknameStore();
  TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setNicknameStore = SetNicknameStore();
    _nicknameController.text = _setNicknameStore.nickname;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

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
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 320.h),
                  AutoSizeText(
                    "시작하기 전",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray90,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  AutoSizeText(
                    "위버님의 닉네임을 설정해주세요",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray90,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  TextFormFieldWidget(
                    textController: _nicknameController,
                    onChanged: (val) {
                      _setNicknameStore.setNickname(val);
                    },
                    hintText: "닉네임을 입력해주세요.",
                    suffix: InkWell(
                      onTap: () {
                        _setNicknameStore.resetNickname();
                        _nicknameController.clear();
                      },
                      child: Image.asset(
                        'assets/icons/close_icon.png',
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                ],
              ),
              DefaultFlatButton(
                onPressed: !_setNicknameStore.isNicknmeValid
                    ? null
                    : () {
                        context.router.replace(const HomeRoute());
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
          );
        }),
      ),
    );
  }
}
