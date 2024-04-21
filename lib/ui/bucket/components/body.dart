import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/stores/bucket_ui/bucket_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_checkbox_listtile_with_subtitle.dart';
import 'package:wiber_mobile/widgets/default_dialog.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  FocusNode _namefocusNode = FocusNode();
  FocusNode _descriptionfocusNode = FocusNode();

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
      ..getUserInfo()
      ..getCategories()
      ..getBucketList();

    if (_userStore != userStore) {
      _userStore = userStore;
    }
  }

  @override
  void dispose() {
    _namefocusNode.dispose();
    _descriptionfocusNode.dispose();
    super.dispose();
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
                  SizedBox(height: 23.h),
                  _buildProfiles(),
                  SizedBox(height: 32.h),
                  _buildCategories(),
                  _buildStatusLine(),
                  _buildBucketList(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomBar(),
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
        right: 16.25.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(width: 12.w),
              AutoSizeText(
                widget.item.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
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

  Widget _buildProfiles() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.h,
            width: double.infinity,
            child: Indexer(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              reversed: true,
              children: [
                const SizedBox(width: 0),
                ...List.generate(
                  widget.item.participants.length,
                  (index) => Indexed(
                    index: index,
                    child: Positioned(
                      left: (MediaQuery.of(context).size.width /
                              widget.item.participants.length) +
                          (20.sp * index),
                      child: Container(
                        width: 100.sp,
                        height: 100.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4.sp,
                          ),
                        ),
                        child: Image.asset(
                          widget.item.participants[index].profileImageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          AutoSizeText(
            widget.item.participants[0].nickname,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlack,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/bucket_profile_icon.png",
                width: 12.w,
                height: 15.h,
              ),
              SizedBox(width: 5.w),
              AutoSizeText(
                "${widget.item.participants.length}명",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray30,
            width: 0.2.sp,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(
                _userStore!.categories.length,
                (index) => InkWell(
                  onTap: () {
                    _uiStore.setSelectedCategoryIndex(index);
                    _userStore!.filterBucketList(
                      _userStore!.categories[_uiStore.selectedCategoryIndex],
                      _uiStore.selectedTabIndex,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 12.h,
                      top: 12.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _uiStore.selectedCategoryIndex == index
                              ? AppColors.primary1
                              : Colors.transparent,
                          width: 2.sp,
                        ),
                      ),
                    ),
                    child: AutoSizeText(
                      _userStore!.categories[index],
                      style: _uiStore.selectedCategoryIndex == index
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
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 12.h,
                    top: 12.h,
                  ),
                  child: AutoSizeText(
                    "+ 새목록",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary1,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusLine() {
    List<String> statusItems = [
      "전체보기",
      "진행중",
      "완료",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Row(
        children: [
          Row(
            children: [
              ...List.generate(
                statusItems.length,
                (index) => Container(
                  margin: EdgeInsets.only(right: 6.w),
                  child: InkWell(
                    onTap: () {
                      _uiStore.setSelectedTabIndex(index);
                      _userStore!.filterBucketList(
                        _userStore!.categories[_uiStore.selectedCategoryIndex],
                        index,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: _uiStore.selectedTabIndex == index
                            ? AppColors.primary2.withOpacity(0.1)
                            : AppColors.gray15,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: AutoSizeText(
                        statusItems[index],
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: _uiStore.selectedTabIndex == index
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
        ],
      ),
    );
  }

  Widget _buildBucketList() {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              _userStore!.filteredBucketList.length,
              (index) {
                var bucket = _userStore!.filteredBucketList[index];
                return DefaultCheckboxListTileWithSubtitle(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  isChecked: bucket.isCompleted,
                  title: bucket.title,
                  subTitle: bucket.body,
                  hasUnderline: false,
                );
              },
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
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

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 40.w,
        right: 40.w,
        top: 10.h,
        bottom: 40.h,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/icons/add_person_icon.png",
              width: 26.w,
              height: 26.h,
            ),
          ),
          InkWell(
            onTap: () {
              _showBottomTextSheet();
            },
            child: Container(
              width: 56.sp,
              height: 56.sp,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary1,
              ),
              child: Center(
                child: Image.asset(
                  "assets/icons/pen_icon.png",
                  width: 22.w,
                  height: 22.h,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/icons/horizontal_icon.png",
              width: 24.w,
              height: 3.h,
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

  void _showBottomTextSheet() {
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
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_uiStore.createNewBucketPhase >= 0)
                TextFormField(
                  autofocus: true,
                  focusNode: _namefocusNode,
                  cursorColor: AppColors.primary1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.tertiaryBlack,
                    ),
                    hintText: "새 버킷리스트",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                  onChanged: (value) {
                    _uiStore.setNewBucketName(value);
                  },
                ),
              if (_uiStore.createNewBucketPhase >= 1)
                TextFormField(
                  focusNode: _descriptionfocusNode,
                  cursorColor: AppColors.primary1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.tertiaryBlack,
                    ),
                    hintText: "새 버킷리스트",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                  onChanged: (value) {
                    _uiStore.setNewBucketDescription(value);
                  },
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Image.asset(
                        "assets/icons/message_icon.png",
                        width: 24.w,
                        height: 22.h,
                      ),
                      SizedBox(width: 15.w),
                      Image.asset(
                        "assets/icons/clock_icon.png",
                        width: 22.w,
                        height: 22.h,
                      ),
                    ]),
                    GestureDetector(
                      onTap: _uiStore.newBucketName.isEmpty
                          ? null
                          : () {
                              if (_uiStore.createNewBucketPhase == 0) {
                                _namefocusNode.unfocus();
                                _descriptionfocusNode.requestFocus();
                              }

                              if (_uiStore.createNewBucketPhase == 1) {
                                _descriptionfocusNode.unfocus();
                              }

                              _uiStore.setCreateNewBucketPhase(
                                  _uiStore.createNewBucketPhase + 1);
                            },
                      child: AutoSizeText(
                        "저장",
                        textAlign: TextAlign.right,
                        style: _uiStore.newBucketName.isEmpty
                            ? TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.tertiaryBlack,
                              )
                            : TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary1,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    ).then((value) => _uiStore.resetNewBucketDatas());
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
