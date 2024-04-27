import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/stores/bucket_ui/bucket_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';

class Body extends StatefulWidget {
  final WiberSpace item;

  const Body({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  BucketUIStore _uiStore = BucketUIStore();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    _uiStore = BucketUIStore();

    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>()
      ..getCategories()
      ..getBucketList();

    if (_userStore != userStore) {
      _userStore = userStore;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  _buildTopbar(),
                  SizedBox(height: 10.h),
                  ...List.generate(widget.item.participants.length, (index) {
                    User user = widget.item.participants[index];
                    return _buildProfiles(user: user);
                  }),
                  SizedBox(height: 10.h),
                  if (widget.item.participants.length < 5)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: DefaultFlatButton(
                        onPressed: () {
                          _showInviteLinkBottomSheet();
                        },
                        buttonColor: AppColors.gray15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/plus_icon.png",
                              width: 17.sp,
                              height: 17.sp,
                            ),
                            SizedBox(width: 14.w),
                            AutoSizeText(
                              "메이트 초대하기",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopbar() {
    return Padding(
      padding: EdgeInsets.only(
        top: 14.h,
        bottom: 14.h,
        left: 24.w,
        right: 12.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              context.router.pop();
            },
            child: Image.asset(
              'assets/icons/chevron_left_icon.png',
              width: 20.w,
              height: 15.h,
            ),
          ),
          AutoSizeText(
            "참여중인 위버 메이트",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlack,
            ),
          ),
          InkWell(
            onTap: () {
              _showSpaceDeleteConfirmDialog();
            },
            child: Image.asset(
              'assets/icons/setting_logout_icon.png',
              width: 20.w,
              height: 20.h,
              color: AppColors.gray50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfiles({required User user}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                user.profileImageUrl,
                width: 48.sp,
                height: 48.sp,
              ),
              SizedBox(width: 10.w),
              AutoSizeText(
                user.nickname,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              if (user.id == _userStore!.user!.id)
                Container(
                  width: 22.w,
                  height: 22.h,
                  margin: EdgeInsets.only(left: 4.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray90,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "나",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (user.id == widget.item.owner)
                Container(
                  width: 14.55.w,
                  height: 12.h,
                  margin: EdgeInsets.only(left: 8.w),
                  child: Image.asset(
                    "assets/icons/crown_icon.png",
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
          if (widget.item.owner == _userStore!.user!.id &&
              user.id != _userStore!.user!.id)
            InkWell(
              onTap: () {
                _showKickMateConfirmDialog(user);
              },
              child: Container(
                width: 19.5.w,
                height: 19.5.h,
                decoration: const BoxDecoration(
                  color: AppColors.gray50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: FaIcon(
                  FontAwesomeIcons.minus,
                  size: 8.sp,
                  color: AppColors.gray15,
                )),
              ),
            ),
        ],
      ),
    );
  }

  void _showSpaceDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultBottomDialog(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AutoSizeText(
                "스페이스에서 나가면  다시 되돌릴 수 없어요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.tertiaryBlack,
                ),
              ),
            ),
            Divider(
              height: 0.2.sp,
              thickness: 0.2.sp,
              color: AppColors.gray10,
            ),
            InkWell(
              onTap: () async {
                context.router.pop();
                _showToast("${widget.item.title} 스페이스가 삭제되었습니다.");
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "스페이스 나가기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.negative,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showKickMateConfirmDialog(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultBottomDialog(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AutoSizeText(
                "선택하신 메이트를 내보낼까요?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.tertiaryBlack,
                ),
              ),
            ),
            Divider(
              height: 0.2.sp,
              thickness: 0.2.sp,
              color: AppColors.gray10,
            ),
            InkWell(
              onTap: () async {
                context.router.pop();
                _showToast("${user.nickname}을(를) 내보내셨습니다.");
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "위버메이트 내보내기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.negative,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showInviteLinkBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: 40.h,
          top: 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "초대하기",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray100,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.pop();
                    },
                    child: Image.asset(
                      "assets/icons/x_icon.png",
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              AutoSizeText(
                "초대링크를 복사해서 파트너에게 전달해보세요.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 14.h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "create-invite-links?dskjfdlskfddsfsdfsddsfs...",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    GestureDetector(
                      child: InkWell(
                        onTap: () {
                          _copyToClipBoard(
                              "create-invite-links?dskjfdlskfddsfsdfsddsfs...");
                        },
                        child: Image.asset(
                          "assets/icons/clipboard_icon.png",
                          width: 19.2.sp,
                          height: 19.2.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              DefaultFlatButton(
                onPressed: () {
                  context.router.pop();
                },
                child: AutoSizeText(
                  "초대링크 공유하기",
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
      ),
    );
  }

  Future<void> _copyToClipBoard(String text) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      Clipboard.setData(ClipboardData(text: text));
      _showToast("초대링크를 복사했어요.");
    });
  }

  void _showToast(String text) {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.gray90.withOpacity(0.9),
      ),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
