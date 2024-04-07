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

    final userStore = context.read<UserStore>()
      ..getUserNickname()
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
                  _buildNickname(),
                  _buildTabs(),
                ],
              ),
              Positioned(
                bottom: 40.h,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              '${_userStore?.nickname ?? "위버"}님',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.gray90,
              ),
            ),
            SizedBox(width: 20.w),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: AppColors.gray100,
              size: 12.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Flexible(
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray30,
                    width: 2.sp,
                  ),
                ),
              ),
              child: TabBar(
                indicatorPadding: EdgeInsets.only(bottom: -1.5.h),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.primary1,
                      width: 2.sp,
                    ),
                  ),
                ),
                onTap: (index) {
                  _uiStore.setSelectedTabIndex(index);
                  _userStore!.filterBucketList(
                    _userStore!.categories[_uiStore.selectedCategoryIndex],
                    index,
                  );
                },
                tabs: [
                  Tab(
                    child: AutoSizeText(
                      '전체',
                      style: _uiStore.selectedTabIndex == 0
                          ? TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary1,
                              fontSize: 14.sp,
                            )
                          : TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryBlack,
                              fontSize: 14.sp,
                            ),
                    ),
                  ),
                  Tab(
                    child: AutoSizeText(
                      '진행중',
                      style: _uiStore.selectedTabIndex == 1
                          ? TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary1,
                              fontSize: 14.sp,
                            )
                          : TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryBlack,
                              fontSize: 14.sp,
                            ),
                    ),
                  ),
                  Tab(
                    child: AutoSizeText(
                      '완료',
                      style: _uiStore.selectedTabIndex == 2
                          ? TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary1,
                              fontSize: 14.sp,
                            )
                          : TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryBlack,
                              fontSize: 14.sp,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            _buildCategoriesLine(),
            Flexible(
              child: SingleChildScrollView(
                child: _buildBucketList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesLine() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    _userStore!.categories.length,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 6.w),
                      child: InkWell(
                        onTap: () {
                          _uiStore.setSelectedCategoryIndex(index);
                          _userStore!.filterBucketList(
                            _userStore!.categories[index],
                            _uiStore.selectedTabIndex,
                          );
                        },
                        onLongPress: () {
                          _uiStore.setSelectedCategory(
                              _userStore!.categories[index]);
                          _showBottomSheet(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: _uiStore.selectedCategoryIndex == index
                                ? AppColors.primary2.withOpacity(0.1)
                                : AppColors.gray15,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AutoSizeText(
                            _userStore!.categories[index],
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: _uiStore.selectedCategoryIndex == index
                                  ? AppColors.primary1
                                  : AppColors.tertiaryBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 15.h,
              ),
              decoration: const BoxDecoration(
                color: AppColors.gray15,
                shape: BoxShape.circle,
              ),
              child: FaIcon(
                FontAwesomeIcons.ellipsis,
                size: 20.sp,
                color: AppColors.gray80,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBucketList() {
    return Column(
      children: [
        ...List.generate(
          _userStore!.filteredBucketList.length,
          (index) {
            var bucket = _userStore!.filteredBucketList[index];
            return DefaultCheckboxListTileWithSubtitle(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              isChecked: bucket.isCompleted,
              title: bucket.title,
              subTitle: bucket.body,
              hasUnderline: true,
              trailing: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: AppColors.gray70,
                size: 16.sp,
              ),
            );
          },
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        child: _buildBottomSheet(context),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.gray10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "카테고리 수정 및 삭제",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray90,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: AppColors.gray100,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          DefaultFlatButton(
            onPressed: () {
              _uiStore.setEditingCategoryName("");
              _showEditModal(context);
            },
            buttonColor: AppColors.lightGray,
            child: AutoSizeText(
              "수정하기",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.gray90,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          DefaultFlatButton(
            onPressed: () {
              _showDeleteModal(context);
            },
            buttonColor: AppColors.negative,
            child: AutoSizeText(
              "삭제하기",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditModal(BuildContext context) {
    double buttonWidth = (MediaQuery.of(context).size.width - 80.w) / 2;

    showDialog(
      context: context,
      builder: (BuildContext context) => DefaultDialog(
        children: Column(
          children: [
            AutoSizeText(
              "카테고리 수정하기",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.gray90,
              ),
            ),
            SizedBox(height: 16.h),
            TextFormFieldWidget(
              onChanged: (val) => _uiStore.setEditingCategoryName(val),
              initialValue: _uiStore.selectedCategory,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                DefaultFlatButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  width: buttonWidth,
                  buttonColor: AppColors.lightGray,
                  child: AutoSizeText(
                    "취소",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray90,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Observer(builder: (context) {
                  return DefaultFlatButton(
                    onPressed: !_uiStore.canEditCategoryName
                        ? null
                        : () {
                            context.router.popUntilRoot();
                            _showToast("카테고리 수정이 완료되었어요");
                          },
                    width: buttonWidth,
                    buttonColor: !_uiStore.canEditCategoryName
                        ? AppColors.lightGray
                        : AppColors.primary1,
                    child: AutoSizeText(
                      "수정하기",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: !_uiStore.canEditCategoryName
                            ? AppColors.gray90
                            : Colors.white,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteModal(BuildContext context) {
    double buttonWidth = (MediaQuery.of(context).size.width - 80.w) / 2;

    showDialog(
      context: context,
      builder: (BuildContext context) => DefaultDialog(
        children: Column(
          children: [
            AutoSizeText(
              "카테고리 삭제하기",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.gray90,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray15,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SizedBox(
                width: double.infinity,
                child: AutoSizeText(
                  _uiStore.selectedCategory,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                DefaultFlatButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  width: buttonWidth,
                  buttonColor: AppColors.lightGray,
                  child: AutoSizeText(
                    "취소",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray90,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Observer(builder: (context) {
                  return DefaultFlatButton(
                    onPressed: () {
                      context.router.popUntilRoot();
                      _showToast("카테고리 삭제가 완료되었어요");
                    },
                    width: buttonWidth,
                    buttonColor: AppColors.negative,
                    child: AutoSizeText(
                      "삭제하기",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ],
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
