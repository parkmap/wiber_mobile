import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  FToast fToast = FToast();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
    }

    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) => Column(
          children: [
            Column(
              children: [
                _buildTopBar(),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 8.h,
                  color: AppColors.gray15,
                ),
                _buildListItem(
                  title: "공지사항",
                  imageUrl: "assets/icons/setting_announce_icon.svg",
                  imageWidth: 20.w,
                  imageHeight: 20.h,
                  trailing: SvgPicture.asset(
                    'assets/icons/setting_item_chevron_right_icon.svg',
                    width: 10.w,
                    height: 12.h,
                  ),
                  onTap: () {
                    context.router.push(const SettingAnnounceRoute());
                  },
                ),
                _buildListItem(
                  title: "자주묻는질문",
                  imageUrl: "assets/icons/setting_faq_icon.svg",
                  imageWidth: 20.w,
                  imageHeight: 20.h,
                  trailing: SvgPicture.asset(
                    'assets/icons/setting_item_chevron_right_icon.svg',
                    width: 10.w,
                    height: 12.h,
                  ),
                  onTap: () {
                    context.router.push(const SettingFaqRoute());
                  },
                ),
                _buildListItem(
                  title: "고객센터",
                  imageUrl: "assets/icons/setting_call_icon.svg",
                  imageWidth: 20.w,
                  imageHeight: 20.h,
                  trailing: SvgPicture.asset(
                    'assets/icons/setting_item_chevron_right_icon.svg',
                    width: 10.w,
                    height: 12.h,
                  ),
                  onTap: () {
                    _showCustomerServiceBottomSheet();
                  },
                ),
                _buildListItem(
                  title: "버전정보",
                  imageUrl: "assets/icons/setting_phone_icon.svg",
                  imageWidth: 15.w,
                  imageHeight: 20.h,
                  trailing: AutoSizeText(
                    "5.29.2",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.tertiaryBlack,
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  height: 8.h,
                  color: AppColors.gray15,
                ),
                SizedBox(height: 8.h),
                _buildListItem(
                  title: "로그아웃",
                  imageUrl: "assets/icons/setting_logout_icon.svg",
                  imageWidth: 20.w,
                  imageHeight: 20.h,
                  trailing: SvgPicture.asset(
                    'assets/icons/setting_item_chevron_right_icon.svg',
                    width: 10.w,
                    height: 12.h,
                  ),
                  onTap: () {
                    _showLogoutConfirmDialog();
                  },
                ),
              ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.router.popUntilRoot();
                },
                child: SvgPicture.asset(
                  'assets/icons/chevron_left_icon.svg',
                  width: 20.w,
                  height: 15.h,
                ),
              ),
              AutoSizeText(
                "마이페이지",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlack,
                ),
              ),
              _userStore!.wiberSpaceList.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        context.router.push(const SettingWiberSpaceRoute());
                      },
                      child: SvgPicture.asset(
                        'assets/icons/setting_icon.svg',
                        width: 20.w,
                        height: 19.h,
                      ),
                    )
                  : SizedBox(
                      width: 20.w,
                    )
            ],
          ),
          SizedBox(height: 40.h),
          InkWell(
            onTap: () {
              context.router.push(const SettingWiberSpaceRoute());
            },
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: _userStore!.user!.profileImageUrl.isEmpty
                      ? Image.asset(
                          'assets/images/default_profile_image.png',
                          width: 48.w,
                          height: 48.h,
                        )
                      : Image.network(
                          _userStore!.user!.profileImageUrl,
                          width: 48.w,
                          height: 48.h,
                        ),
                ),
                SizedBox(width: 16.w),
                AutoSizeText(
                  _userStore!.user!.nickname,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
                SizedBox(width: 11.w),
                SvgPicture.asset(
                  'assets/icons/chevron_right_icon.svg',
                  width: 10.w,
                  height: 12.h,
                ),
              ],
            ),
          ),
          if (_userStore!.wiberSpaceList.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.symmetric(
                horizontal: 17.w,
                vertical: 17.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray15,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/setting_people_icon.svg",
                  width: 18.w,
                  height: 18.h,
                ),
                SizedBox(width: 8.w),
                AutoSizeText(
                  "${_userStore!.wiberSpaceList.length}개의 위버 스페이스 참여중",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ]),
            ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required String imageUrl,
    required double imageWidth,
    required double imageHeight,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 20.h,
          left: 23.w,
          right: 27.w,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                  child: SvgPicture.asset(
                    imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
                SizedBox(width: 13.w),
                AutoSizeText(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ],
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  void _showCustomerServiceBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: 60.h,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "고객센터",
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
                    child: SvgPicture.asset(
                      "assets/icons/x_icon.svg",
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              AutoSizeText(
                "고객지원 이메일",
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
                      "wiber.now@gmail.com",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    GestureDetector(
                      child: InkWell(
                        onTap: () {
                          _copyToClipBoard("wiber.now@gmail.com");
                        },
                        child: SvgPicture.asset(
                          "assets/icons/clipboard_icon.svg",
                          width: 19.2.sp,
                          height: 19.2.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<void> _copyToClipBoard(String text) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      Clipboard.setData(ClipboardData(text: text));
      _showToast("링크가 복사되었어요");
    });
  }

  void _showLogoutConfirmDialog() {
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
                "로그아웃 하시겠어요?",
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
                await _userStore!.logout();
                context.router.replaceAll([const SplashRoute()]);
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "로그아웃",
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
}
