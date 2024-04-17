import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/stores/home_ui/home_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_checkbox_listtile_with_subtitle.dart';
import 'package:wiber_mobile/widgets/default_dialog.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wiber_mobile/widgets/wiber_space_list_tile.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  HomeUIStore _uiStore = HomeUIStore();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    _uiStore = HomeUIStore();

    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>()..getUserInfoAndWiberSpaceList();

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
                  _buildNickname(),
                  _buildWiberSpaces(),
                ],
              ),
              Positioned(
                bottom: 72.h,
                right: 30.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.5.w,
                    vertical: 15.5.h,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary1,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray90.withOpacity(0.3),
                        blurRadius: 10.sp,
                        offset: Offset(0, 5.sp),
                      ),
                    ],
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 16.5.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        },
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
                  'assets/icons/notification_icon.png',
                  width: 18.12.w,
                  height: 19.5.h,
                ),
              ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/profile_icon.png',
                  width: 22.w,
                  height: 22.h,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  '${_userStore?.user?.nickname ?? "위버"} 님이',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
                SizedBox(height: 2.h),
                AutoSizeText(
                  '참여중인 위버스페이스',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ],
            ),
            Image.asset(
              _userStore?.user?.profileImageUrl ??
                  'assets/images/default_profile_image.png',
              width: 56.sp,
              height: 56.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWiberSpaces() {
    return Flexible(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.gray20,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            child: Column(
              children: [
                ...List.generate(
                  _userStore!.wiberSpaceList.length,
                  (index) => Column(
                    children: [
                      WiberSpaceListTile(
                        item: _userStore!.wiberSpaceList[index],
                        isOwner: _userStore!.user!.id ==
                            _userStore!.wiberSpaceList[index].id,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                )
              ],
            ),
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
}
