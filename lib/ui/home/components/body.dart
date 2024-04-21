import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/home_ui/home_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_checkbox_listtile_with_subtitle.dart';
import 'package:wiber_mobile/widgets/default_dialog.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                child: InkWell(
                  onTap: () {
                    _showBottomTextSheet(null);
                  },
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
                      _buildWiberSpaceItem(
                        item: _userStore!.wiberSpaceList[index],
                        isOwner: _userStore!.user!.id ==
                            _userStore!.wiberSpaceList[index].id,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWiberSpaceItem({
    required WiberSpace item,
    required bool isOwner,
  }) {
    return InkWell(
      onTap: () {
        context.router.push(BucketRoute(item: item));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.w,
          right: 26.w,
          top: 16.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  item.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlack,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        item.isFavorite
                            ? "assets/icons/favorite_on_icon.png"
                            : "assets/icons/favorite_off_icon.png",
                        width: 24.sp,
                        height: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    InkWell(
                      onTap: () {
                        showWiberMenuDialog(item);
                      },
                      child: Container(
                        width: 24.sp,
                        height: 24.sp,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 3.5.sp,
                        ),
                        child: Image.asset(
                          "assets/icons/vertical_icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    _showBottomProfiles(item.participants, item);
                  },
                  child: SizedBox(
                    width: 16.sp * (item.participants.length + 1),
                    height: 28.sp,
                    child: Indexer(
                      alignment: AlignmentDirectional.centerEnd,
                      clipBehavior: Clip.none,
                      children: [
                        const SizedBox.shrink(),
                        ...List.generate(
                          item.participants.length,
                          (index) => Indexed(
                            index: -index,
                            child: Positioned(
                              left: 16.sp * index,
                              child: Container(
                                width: 28.sp,
                                height: 28.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.sp,
                                  ),
                                ),
                                child: Image.asset(
                                  item.participants[index].profileImageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/list_icon.png",
                      width: 15.w,
                      height: 17.5.h,
                    ),
                    SizedBox(width: 4.w),
                    AutoSizeText(
                      "${item.completeCount}/${item.maxCount}",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tertiaryBlack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNewSpaceItem() {
    return InkWell(
      onTap: () {
        _showBottomTextSheet(null);
      },
      child: DottedBorder(
        strokeWidth: 3.w,
        color: AppColors.subduedBlack,
        radius: Radius.circular(15.r),
        dashPattern: const [10, 10],
        borderType: BorderType.RRect,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 64.5.h,
            bottom: 64.5.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 20.sp,
                height: 20.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary1,
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 10.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AutoSizeText(
                "새로운 위버스페이스 생성하기",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showWiberMenuDialog(WiberSpace item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultBottomDialog(
          children: [
            InkWell(
              onTap: () {
                context.router.popUntilRoot();
                _showBottomInviteSheet(item);
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "위버메이트 초대하기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ),
            if (item.owner == _userStore!.user!.id)
              Column(
                children: [
                  Divider(
                    height: 0.2.sp,
                    thickness: 0.2.sp,
                    color: AppColors.gray10,
                  ),
                  InkWell(
                    onTap: () {
                      context.router.popUntilRoot();
                      _showBottomTextSheet(item);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: AutoSizeText(
                        "스페이스 이름 수정하기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Divider(
              height: 0.2.sp,
              thickness: 0.2.sp,
              color: AppColors.gray10,
            ),
            InkWell(
              onTap: () {
                context.router.popUntilRoot();
                _showExitConfirmDialog(item);
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
            )
          ],
        );
      },
    );
  }

  void _showBottomProfiles(List<User> users, WiberSpace item) {
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
        constraints: BoxConstraints(
          minHeight: 160.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "참여한 위버메이트",
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
            SizedBox(height: 10.h),
            ...List.generate(
              users.length,
              (index) {
                User user = users[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
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
                      if (user.id == item.owner)
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomTextSheet(WiberSpace? item) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 28.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
          top: 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              cursorColor: AppColors.primary1,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray100,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryBlack,
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  context.router.pop(context);

                  _showToast(
                    item == null ? "스페이스가 생성되었습니다." : "스페이스가 수정되었습니다.",
                  );
                },
                child: AutoSizeText(
                  item == null ? "생성" : "수정",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmDialog(WiberSpace item) {
    double buttonWidth = (MediaQuery.of(context).size.width - 100.w) / 2;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultDialog(
          contentPadding: EdgeInsets.zero,
          borderRadius: 14.r,
          children: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    AutoSizeText(
                      "스페이스 나가기",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: 8.h),
                    AutoSizeText(
                      "스페이스에서 나가면 다시 되돌릴 수 없어요.",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: buttonWidth,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xff3C3C43),
                          width: 0.2.sp,
                        ),
                        right: BorderSide(
                          color: const Color(0xff3C3C43),
                          width: 0.2.sp,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AutoSizeText(
                        "취소",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: buttonWidth,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xff3C3C43),
                          width: 0.2.sp,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _showToast("스페이스가 삭제되었습니다.");
                      },
                      child: AutoSizeText(
                        "나가기",
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
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomInviteSheet(WiberSpace item) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 48.h),
            AutoSizeText(
              "초대링크를 복사해서 파트너에게 전달해보세요.",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.gray10,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 12.w,
              ),
              child: Row(
                children: [
                  AutoSizeText(
                    "create-invite-links?dskjfdlskfddsfsdfsddsfs...",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryBlack,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/clipboard_icon.png",
                      width: 19.2.sp,
                      height: 19.2.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            DefaultFlatButton(
              onPressed: () {},
              child: AutoSizeText(
                "초대링크 공유하기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
