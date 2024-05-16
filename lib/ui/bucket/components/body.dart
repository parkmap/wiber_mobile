import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/bucket_ui/bucket_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/custom_circle_checkbox.dart';
import 'package:wiber_mobile/widgets/default_checkbox_listtile_with_subtitle.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

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
  TextEditingController _newCategoryController = TextEditingController();
  late FocusNode _newCategoryFocusNode;

  @override
  void initState() {
    super.initState();
    _uiStore = BucketUIStore();

    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    _namefocusNode = FocusNode();
    _descriptionfocusNode = FocusNode();
    _newCategoryFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;

      await userStore.getCategoryList(spaceId: widget.item.id);
      await userStore.getBucketList(spaceId: widget.item.id);
    }
  }

  @override
  void dispose() {
    _namefocusNode.dispose();
    _descriptionfocusNode.dispose();
    _newCategoryFocusNode.dispose();
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
                onTap: () {
                  context.router.push(const SettingRoute());
                },
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
    List<List> profileMatrix = [
      [0.0.sp],
      [-15.sp, 15.sp],
      [-30.sp, 0.sp, 30.sp],
      [-45.sp, -15.sp, 15.sp, 45.sp],
      [-60.sp, -30.sp, 0.sp, 30.sp, 60.sp],
    ];
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.router.push(BucketParticipantsRoute(item: widget.item));
            },
            child: SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Indexer(
                alignment: AlignmentDirectional.center,
                clipBehavior: Clip.none,
                reversed: true,
                children: [
                  const SizedBox(width: 0),
                  ...List.generate(
                    widget.item.members.length,
                    (index) => Indexed(
                      index: index,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100.sp,
                          height: 100.sp,
                          transform: Matrix4.translationValues(
                            profileMatrix[widget.item.members.length - 1]
                                [index],
                            0.0,
                            0.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4.sp,
                            ),
                          ),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 100.sp,
                              height: 100.sp,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 96.sp,
                              height: 96.sp,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: widget.item.members[index].profileImageUrl
                                      .isEmpty
                                  ? Image.asset(
                                      "assets/images/default_profile_image.png",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      widget
                                          .item.members[index].profileImageUrl,
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
          SizedBox(height: 10.h),
          AutoSizeText(
            widget.item.members[0].nickname,
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
                "${widget.item.members.length}명",
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
                    // _userStore!.getBucketList(
                    //   spaceId: widget.item.id,
                    //   _userStore!.categories[_uiStore.selectedCategoryIndex],
                    //   _uiStore.selectedTabIndex,
                    // );
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
                onTap: () {
                  _showNewCategoryBottomSheet(context);
                },
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
                      // _userStore!.filterBucketList(
                      //   _userStore!.categories[_uiStore.selectedCategoryIndex],
                      //   index,
                      // );
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
                return InkWell(
                  onTap: () {
                    context.router.push(BucketDetailRoute(
                      space: widget.item,
                      item: bucket,
                      onDelete: () {
                        context.router.popUntilRouteWithName("BucketRoute");
                        _showToast("버킷 1개를 삭제했어요.");
                      },
                    ));
                  },
                  child: DefaultCheckboxListTileWithSubtitle(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    isChecked: bucket.isCompleted,
                    title: bucket.title,
                    subTitle: bucket.body,
                    hasUnderline: false,
                  ),
                );
              },
            ),
            SizedBox(height: 120.h),
          ],
        ),
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
            onTap: () {
              _showInviteLinkBottomSheet();
            },
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
            onTap: () {
              _showSortingListBottomSheet();
            },
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  autofocus: true,
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
              if (_uiStore.createNewBucketPhase >= 3 &&
                  _uiStore.newBucketEndDate.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  margin: EdgeInsets.only(bottom: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray15,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        DateFormat("YYYY년 MM월 dd일")
                            .format(DateTime.parse(_uiStore.newBucketEndDate)),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.tertiaryBlack,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _uiStore.setNewBucketEndDate("");
                              _uiStore.setCreateNewBucketPhase(2);
                            },
                            child: Image.asset(
                              "assets/icons/x_icon.png",
                              width: 10.w,
                              height: 10.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              if (_uiStore.createNewBucketPhase <= 1) {
                                _uiStore.setCreateNewBucketPhase(
                                    _uiStore.createNewBucketPhase + 1);
                              }

                              if (_uiStore.createNewBucketPhase == 1) {
                                _namefocusNode.unfocus();
                                _descriptionfocusNode.requestFocus();
                              }

                              if (_uiStore.createNewBucketPhase == 2) {
                                _descriptionfocusNode.unfocus();
                                _showBottomDateFieldSheet();
                              }

                              if (_uiStore.createNewBucketPhase == 3) {
                                context.router.pop();
                              }
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

  void _showBottomDateFieldSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
          bottom: 16.h,
          top: 24.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "날짜 선택",
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
                    width: 15.sp,
                    height: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 254.h,
              width: double.infinity,
              child: Center(
                child: Container(
                  width: 300.w,
                  height: 215.h,
                  decoration: BoxDecoration(
                    color: AppColors.gray10,
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    minimumDate:
                        DateTime.now().subtract(const Duration(days: 1)),
                    onDateTimeChanged: (val) {
                      _uiStore.setNewBucketEndDate(val.toString());
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            DefaultFlatButton(
              onPressed: () {
                if (_uiStore.newBucketEndDate.isEmpty) {
                  _uiStore.setNewBucketEndDate(DateTime.now().toString());
                }
                _uiStore.setCreateNewBucketPhase(3);
                context.router.pop();
              },
              buttonColor: AppColors.primary1,
              child: AutoSizeText(
                "날짜 선택하기",
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
    );
  }

  void _showSortingListBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(
        builder: (context) {
          return Container(
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
                      "정렬 기준",
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
                SizedBox(height: 40.h),
                ...List.generate(
                  _uiStore.sortingList.length,
                  (index) {
                    String sortItem = _uiStore.sortingList[index];
                    return InkWell(
                      onTap: () {
                        _uiStore.setSelectedSort(sortItem);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              sortItem,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlack,
                              ),
                            ),
                            CustomCircleCheckbox(
                              isChecked: _uiStore.selectedSort == sortItem,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30.h),
                DefaultFlatButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  buttonColor: AppColors.primary1,
                  child: AutoSizeText(
                    "확인",
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
        },
      ),
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

  void _showNewCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.95,
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Container(
              child: _buildNewCategoryBottomSheet(context, isKeyboardVisible),
            );
          },
        );
      },
    );
  }

  Widget _buildNewCategoryBottomSheet(
      BuildContext context, bool isKeyboardVisible) {
    return Observer(builder: (context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.gray10,
              spreadRadius: 2,
            ),
          ],
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.95,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "새 카테고리 만들기",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray90,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.router.pop();
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
                  TextFormFieldWidget(
                    textController: _newCategoryController,
                    onChanged: (val) {
                      _uiStore.editingCategoryName = val;
                    },
                    autoFocus: true,
                    focusNode: _newCategoryFocusNode,
                    hintText: "새 카테고리 이름을 입력해주세요",
                    maxLength: 6,
                    suffixActions: () {
                      _uiStore.setNewBucketDetailCategory("");
                      _newCategoryController.clear();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: DefaultFlatButton(
                onPressed: _uiStore.editingCategoryName.isEmpty
                    ? null
                    : () async {
                        var res = await _userStore!.createCategory(
                          spaceId: widget.item.id,
                          title: _uiStore.editingCategoryName,
                        );

                        if (res != null) {
                          context.router.pop();
                          _showToast("새 카테고리를 만들었어요.");
                        }
                      },
                detectKeyboard: true,
                isKeyboardVisible: isKeyboardVisible,
                child: AutoSizeText(
                  "완료",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
