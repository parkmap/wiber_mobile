import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_share.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/user/user.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/home_ui/home_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/utils/text_utils.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_dialog.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/loading_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  UserStore? _userStore;
  HomeUIStore _uiStore = HomeUIStore();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    _uiStore = HomeUIStore();
    fToast.init(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
      await userStore.getUserInfo();
      await userStore.getWiberSpaceList();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tempSpaceId = prefs.getString("temp_space_id") ?? "";
    final tempShareId = prefs.getString("temp_share_id") ?? "";

    if (tempSpaceId != "" && tempShareId != "") {
      var res = await userStore.enterWiberSpaceInvitation();
      await userStore.getWiberSpaceList();
      if (res != null && mounted) {
        if (res is DioException) {
          _showToast(res.error.toString());
          return;
        }
        context.router.push(BucketRoute(
            item: userStore.wiberSpaceList
                .where((space) => space.id == tempSpaceId)
                .first));
        prefs.remove("temp_space_id");
        prefs.remove("temp_share_id");
        return;
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground
        debugPrint("App is in the foreground");
        didChangeDependencies();
        break;
      case AppLifecycleState.inactive:
        // App is in an inactive state and is not receiving user input
        debugPrint("App is inactive");
        break;
      case AppLifecycleState.paused:
        // App is in background
        debugPrint("App is in the background");
        break;
      case AppLifecycleState.detached:
        // App is detached
        debugPrint("App is detached");
        break;
      case AppLifecycleState.hidden:
        // App is hidden
        debugPrint("App is hidden");
        break;
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
                child: SvgPicture.asset(
                  'assets/icons/notification_icon.svg',
                  width: 18.12.w,
                  height: 19.5.h,
                ),
              ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () {
                  context.router.push(const SettingRoute());
                },
                child: SvgPicture.asset(
                  'assets/icons/profile_icon.svg',
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
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.hardEdge,
            child: _userStore?.user?.profileImageUrl == null ||
                    _userStore?.user?.profileImageUrl == ""
                ? Image.asset(
                    'assets/images/default_profile_image.png',
                    width: 56.sp,
                    height: 56.sp,
                  )
                : Image.network(
                    _userStore!.user!.profileImageUrl,
                    width: 56.sp,
                    height: 56.sp,
                  ),
          ),
        ],
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
            child: _userStore!.isLoadingWiberspace
                ? Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: LoadingSpinner(
                      width: 80.sp,
                      height: 80.sp,
                    ),
                  )
                : _userStore!.wiberSpaceList.isEmpty
                    ? _buildCreateNewSpaceItem()
                    : Column(
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
                    // InkWell(
                    //   onTap: () {},
                    //   child: Image.asset(
                    //     item.isFavorite
                    //         ? "assets/icons/favorite_on_icon.png"
                    //         : "assets/icons/favorite_off_icon.png",
                    //     width: 24.sp,
                    //     height: 24.sp,
                    //   ),
                    // ),
                    // SizedBox(width: 16.w),
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
                        child: SvgPicture.asset(
                          "assets/icons/vertical_icon.svg",
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
                    _showBottomProfiles(item.members, item);
                  },
                  child: SizedBox(
                    width: 16.sp * (item.members.length + 1),
                    height: 28.sp,
                    child: Indexer(
                      alignment: AlignmentDirectional.centerEnd,
                      clipBehavior: Clip.none,
                      children: [
                        const SizedBox.shrink(),
                        ...List.generate(
                          item.members.length,
                          (index) => Indexed(
                            index: -index,
                            child: Positioned(
                              left: 16.sp * index,
                              child: SizedBox(
                                width: 28.sp,
                                height: 28.sp,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 28.sp,
                                        height: 28.sp,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: 26.sp,
                                        height: 26.sp,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: item.members[index]
                                                .profileImageUrl.isEmpty
                                            ? Image.asset(
                                                "assets/images/default_profile_image.png",
                                                width: 26.sp,
                                                height: 26.sp,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                item.members[index]
                                                    .profileImageUrl,
                                                width: 26.sp,
                                                height: 26.sp,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ]),
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
                    SvgPicture.asset(
                      "assets/icons/list_icon.svg",
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
              onTap: () async {
                var res = await _userStore!
                    .createWiberSpaceInviteLink(spaceId: item.id);

                if (res != null) {
                  if (res is DioError) {
                    _showToast(res.error.toString());
                  } else if (res.data["share_link"] != null) {
                    context.router.popUntilRoot();
                    _showBottomInviteSheet(item, res.data["share_link"]);
                  }
                }
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
                  child: SvgPicture.asset(
                    "assets/icons/x_icon.svg",
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
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: user.profileImageUrl.isEmpty
                            ? Image.asset(
                                "assets/images/default_profile_image.png",
                                width: 48.sp,
                                height: 48.sp,
                              )
                            : Image.network(
                                user.profileImageUrl,
                                width: 48.sp,
                                height: 48.sp,
                              ),
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
                          child: SvgPicture.asset(
                            "assets/icons/crown_icon.svg",
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 8.h,
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
              initialValue: item?.title ?? "",
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
              onChanged: (value) {
                _uiStore.setWiberSpaceTitle(value);
              },
            ),
            Observer(
              builder: (context) {
                return SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _uiStore.wiberSpaceTitle.isEmpty ||
                            _uiStore.isCreatingSpace ||
                            _uiStore.isEditingSpace
                        ? null
                        : () async {
                            try {
                              if (item == null) {
                                _uiStore.isCreatingSpace = true;
                                var res = await _userStore!.createWiberSpace(
                                  title: _uiStore.wiberSpaceTitle,
                                );

                                if (res != null) {
                                  if (res is DioError) {
                                    _showToast(res.error.toString());

                                    context.router.pop(context);
                                  } else if (res.data["message"] ==
                                      "같은 이름의 스페이스가 이미 존재합니다.") {
                                    context.router
                                        .popUntilRouteWithName("HomeRoute");
                                    _uiStore.isCreatingSpace = false;
                                    _showToast("같은 이름의 스페이스가 이미 존재합니다.");
                                  } else if (res.data["message"] ==
                                      "스페이스 생성 제한을 초과했습니다.") {
                                    context.router
                                        .popUntilRouteWithName("HomeRoute");
                                    _uiStore.isCreatingSpace = false;
                                    _showToast("스페이스 생성 제한을 초과했습니다.");
                                  } else {
                                    context.router
                                        .popUntilRouteWithName("HomeRoute");
                                    await _userStore!.getWiberSpaceList();
                                    _uiStore.isCreatingSpace = false;

                                    _showToast("스페이스가 생성되었습니다.");
                                  }
                                }
                              } else {
                                _uiStore.isEditingSpace = true;
                                var res = await _userStore!.updateWiberSpace(
                                  spaceId: item.id,
                                  title: _uiStore.wiberSpaceTitle,
                                );

                                if (res != null) {
                                  await _userStore!.getWiberSpaceList();
                                  _uiStore.isEditingSpace = false;

                                  context.router
                                      .popUntilRouteWithName("HomeRoute");
                                  _showToast("스페이스가 업데이트 되었습니다.");
                                }
                              }

                              _uiStore.wiberSpaceTitle = "";

                              _uiStore.isCreatingSpace = false;
                              _uiStore.isEditingSpace = false;
                            } catch (err) {
                              print(err);
                              _uiStore.isCreatingSpace = false;
                              _uiStore.isEditingSpace = false;
                            }
                          },
                    child: _uiStore.isCreatingSpace || _uiStore.isEditingSpace
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: LoadingSpinner(
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: 8.h,
                              bottom: 8.h,
                              left: 20.w,
                            ),
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
                );
              },
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
                        context.router.pop();
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
                      onTap: () async {
                        dynamic res;

                        if (item.owner == _userStore!.user!.id) {
                          res = await _userStore!
                              .deleteWiberSpace(spaceId: item.id);
                        } else {
                          res = await _userStore!
                              .leaveWiberSpace(spaceId: item.id);
                        }

                        if (res != null) {
                          _userStore!.getWiberSpaceList();
                          context.router.popUntilRoot();
                          _showToast("스페이스가 삭제되었습니다.");
                        }
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

  void _showBottomInviteSheet(WiberSpace item, String link) {
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
                  child: SvgPicture.asset(
                    "assets/icons/x_icon.svg",
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
                    TextUtils.getShortenedString(val: link, length: 35),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryBlack,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  InkWell(
                    onTap: () {
                      _copyToClipBoard(link);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/clipboard_icon.svg",
                      width: 19.2.sp,
                      height: 19.2.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            DefaultFlatButton(
              onPressed: () {
                context.router.popUntilRoot();
                _showInviteLinkShareBottomSheet(link);
              },
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

  Future<void> _copyToClipBoard(String text) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      Clipboard.setData(ClipboardData(text: text));
      _showToast("초대링크를 복사했어요.");
    });
  }

  void _showInviteLinkShareBottomSheet(String link) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 128.h,
          top: 16.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/launcher_image.png",
                        width: 32.w,
                        height: 32.h,
                      ),
                      SizedBox(width: 6.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "위버 초대링크",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            TextUtils.getShortenedString(val: link, length: 35),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/link_share_close_icon.svg",
                      width: 30.sp,
                      height: 30.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      bool isKakaoTalkSharingAvailable = await ShareClient
                          .instance
                          .isKakaoTalkSharingAvailable();

                      if (isKakaoTalkSharingAvailable) {
                        try {
                          Uri uri = await ShareClient.instance
                              .shareDefault(template: _getKakaotalkFeed(link));
                          await ShareClient.instance.launchKakaoTalk(uri);
                        } catch (err) {
                          _showToast("에러로 인해 카카오톡 공유를 실패했어요. $err");
                        }
                      } else {
                        _showToast("카카오톡으로 공유가 불가능합니다. 카카오톡을 설치해주세요.");
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 56.sp,
                          height: 56.sp,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "assets/icons/kakaotalk_share_icon.png",
                            width: 48.sp,
                            height: 48.sp,
                          ),
                        ),
                        SizedBox(height: 9.h),
                        AutoSizeText(
                          "카카오톡",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FeedTemplate _getKakaotalkFeed(String link) {
    return FeedTemplate(
      content: Content(
        title: '위버스페이스 초대',
        description: '함께 이룰 수 있는 목표를 세워보세요!',
        imageUrl: Uri.parse(
            'https://res.cloudinary.com/ddgoy0mpu/image/upload/v1716294105/Wiber/bdmjlzncqg6ml1hpdq8k.png'),
        link: Link(
          webUrl: Uri.parse(link),
          mobileWebUrl: Uri.parse(link),
        ),
      ),
      buttons: [
        Button(
          title: '웹으로 보기',
          link: Link(
            webUrl: Uri.parse(link),
            mobileWebUrl: Uri.parse(link),
          ),
        ),
      ],
    );
  }
}
