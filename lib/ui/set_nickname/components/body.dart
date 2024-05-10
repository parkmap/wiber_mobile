import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/set_nickname/set_nickname_store.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SetNicknameStore _setNicknameStore = SetNicknameStore();
  final TextEditingController _nicknameController = TextEditingController();
  late FocusNode _nicknameFocusNode;

  @override
  void initState() {
    super.initState();
    _setNicknameStore = SetNicknameStore();
    _nicknameController.text = _setNicknameStore.nickname;
    _nicknameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (contex, isKeyboardVisible) {
      return SizedBox(
        width: double.infinity,
        child: Observer(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 45.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            "반가워요",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray90,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Image.asset(
                            "assets/icons/set_nickname_icon.png",
                            width: 24.sp,
                            height: 24.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      AutoSizeText(
                        "먼저 닉네임을 적어주세요",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray90,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      TextFormFieldWidget(
                        textController: _nicknameController,
                        onChanged: (val) {
                          _setNicknameStore.setNickname(val);
                        },
                        focusNode: _nicknameFocusNode,
                        hintText: "닉네임을 입력해주세요.",
                        maxLength: 6,
                        errorText: _setNicknameStore.nickname.length > 6
                            ? "최대 여섯글자까지 가능합니다"
                            : null,
                        suffixActions: () {
                          _setNicknameStore.resetNickname();
                          _nicknameController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              DefaultFlatButton(
                onPressed: !_setNicknameStore.isNicknmeValid
                    ? null
                    : () {
                        context.router.push(
                          SetProfileRoute(
                            nickname: _setNicknameStore.nickname,
                          ),
                        );
                      },
                detectKeyboard: true,
                isKeyboardVisible: isKeyboardVisible,
                child: AutoSizeText(
                  "다음",
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
      );
    });
  }
}
