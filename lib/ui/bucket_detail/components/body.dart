import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/category/category.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/stores/bucket_ui/bucket_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/utils/text_utils.dart';
import 'package:wiber_mobile/widgets/custom_circle_checkbox.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

class Body extends StatefulWidget {
  final WiberSpace space;
  final Bucket item;
  final VoidCallback onDelete;
  final VoidCallback onBack;

  const Body({
    Key? key,
    required this.space,
    required this.item,
    required this.onDelete,
    required this.onBack,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  BucketUIStore _uiStore = BucketUIStore();
  TextEditingController _newCategoryController = TextEditingController();
  late FocusNode _newCategoryFocusNode;
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    _uiStore = BucketUIStore();
    _newCategoryFocusNode = FocusNode();

    _uiStore.tempBucket = widget.item;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;

      await _userStore?.getCategoryList(spaceId: widget.space.id);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newCategoryController.dispose();
    _newCategoryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) =>
            _uiStore.isEditing ? _buildEditMode() : _buildNormalMode(),
      ),
    );
  }

  Widget _buildNormalMode() {
    return GestureDetector(
      onTap: () => _uiStore.isEditing = true,
      child: Column(
        children: [
          _buildNormalTopBar(),
          SizedBox(height: 24.h),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildNormalTopBody(),
                  SizedBox(height: 47.h),
                  Container(
                    width: double.infinity,
                    height: 16.h,
                    color: AppColors.gray15,
                  ),
                  SizedBox(height: 42.h),
                  _buildNormalDescription(),
                  SizedBox(height: 16.h),
                  _buildNormalEndDate(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditMode() {
    return Column(
      children: [
        _buildEditTopBar(),
        SizedBox(height: 24.h),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildEditTopBody(),
                SizedBox(height: 47.h),
                Container(
                  width: double.infinity,
                  height: 16.h,
                  color: AppColors.gray15,
                ),
                SizedBox(height: 42.h),
                _buildEditDescription(),
                SizedBox(height: 16.h),
                _buildEditEndDate(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNormalTopBar() {
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
                onTap: () async {
                  await _userStore!.getBucketList(spaceId: widget.space.id);
                  context.router.pop();
                },
                child: Image.asset(
                  'assets/icons/chevron_left_icon.png',
                  width: 20.w,
                  height: 15.h,
                ),
              ),
              InkWell(
                onTap: () {
                  _showDeleteBucketConfirmDialog();
                },
                child: Image.asset(
                  'assets/icons/delete_icon.png',
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

  Widget _buildEditTopBar() {
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
                onTap: () async {
                  await _userStore!.updateBucket(
                    spaceId: widget.space.id,
                    categoryId: _uiStore.tempBucket!.category,
                    bucketId: _uiStore.tempBucket!.id,
                    title: _uiStore.tempBucket!.title == widget.item.title
                        ? null
                        : _uiStore.tempBucket!.title,
                    content: _uiStore.tempBucket!.body == widget.item.body
                        ? null
                        : _uiStore.tempBucket!.body,
                    date: _uiStore.tempBucket!.endDate == widget.item.endDate
                        ? null
                        : _uiStore.tempBucket!.endDate,
                  );
                  await _userStore!.getBucketList(spaceId: widget.space.id);
                  widget.onBack();
                },
                child: Image.asset(
                  'assets/icons/chevron_left_icon.png',
                  width: 20.w,
                  height: 15.h,
                ),
              ),
              InkWell(
                onTap: () {
                  _showDeleteBucketConfirmDialog();
                },
                child: Image.asset(
                  'assets/icons/delete_icon.png',
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

  Widget _buildNormalTopBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16.sp * (widget.space.members.length + 1),
            height: 28.sp,
            child: Indexer(
              alignment: AlignmentDirectional.centerEnd,
              clipBehavior: Clip.none,
              children: [
                const SizedBox.shrink(),
                ...List.generate(
                  widget.space.members.length,
                  (index) => Indexed(
                    index: -index,
                    child: Positioned(
                      left: 15.sp * index,
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
                            child: widget.space.members[index].profileImageUrl
                                    .isEmpty
                                ? Image.asset(
                                    "assets/images/default_profile_image.png",
                                    width: 26.sp,
                                    height: 26.sp,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    widget.space.members[index].profileImageUrl,
                                    width: 26.sp,
                                    height: 26.sp,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          AutoSizeText(
            _uiStore.tempBucket!.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlack,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary2.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  _uiStore.tempBucket!.category.isEmpty
                      ? "전체"
                      : _userStore!.categories
                          .where((el) => el.id == _uiStore.tempBucket!.category)
                          .toList()[0]
                          .title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary1,
                  ),
                ),
                SizedBox(width: 6.w),
                Image.asset(
                  "assets/icons/caret_down_icon.png",
                  width: 8.w,
                  height: 6.h,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditTopBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: false,
            initialValue: _uiStore.tempBucket!.title,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: AppColors.primary1,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.tertiaryBlack,
              ),
              hintText: "버킷 이름을 입력해주세요.",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlack,
            ),
            onChanged: (value) {
              Bucket bucket = Bucket(
                id: _uiStore.tempBucket!.id,
                title: value,
                body: _uiStore.tempBucket!.body,
                category: _uiStore.tempBucket!.category,
                endDate: _uiStore.tempBucket!.endDate,
                isCompleted: _uiStore.tempBucket!.isCompleted,
              );

              _uiStore.tempBucket = bucket;
            },
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              _showBottomCategorySheet(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary2.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    _uiStore.tempBucket!.category.isEmpty
                        ? "전체"
                        : _userStore!.categories
                            .where(
                                (el) => el.id == _uiStore.tempBucket!.category)
                            .toList()[0]
                            .title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary1,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Image.asset(
                    "assets/icons/caret_down_icon.png",
                    width: 8.w,
                    height: 6.h,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/icons/message_icon.png",
            width: 22.w,
            height: 20.h,
          ),
          SizedBox(width: 17.w),
          Flexible(
            child: AutoSizeText(
              _uiStore.tempBucket!.body,
              textAlign: TextAlign.start,
              wrapWords: true,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/message_icon.png",
                width: 22.w,
                height: 20.h,
              ),
              SizedBox(width: 8.w),
              AutoSizeText(
                "메모",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 16.h,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.gray15,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextFormField(
                autofocus: false,
                initialValue: _uiStore.tempBucket!.body,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: AppColors.primary1,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tertiaryBlack,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: "버킷 메모를 입력해주세요.",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryBlack,
                ),
                onChanged: (value) {
                  Bucket bucket = Bucket(
                    id: _uiStore.tempBucket!.id,
                    title: _uiStore.tempBucket!.title,
                    body: value,
                    category: _uiStore.tempBucket!.category,
                    endDate: _uiStore.tempBucket!.endDate,
                    isCompleted: _uiStore.tempBucket!.isCompleted,
                  );

                  _uiStore.tempBucket = bucket;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalEndDate() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/clock_icon.png",
            width: 22.w,
            height: 22.h,
          ),
          SizedBox(width: 17.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.gray15,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  TextUtils.canParseDateTime(_uiStore.tempBucket!.endDate!) &&
                          _uiStore.tempBucket!.endDate!.isNotEmpty
                      ? "${DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(_uiStore.tempBucket!.endDate!))} 까지"
                      : "완료일이 없습니다",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                ),
                SizedBox(width: 6.w),
                Image.asset(
                  "assets/icons/x_icon.png",
                  width: 10.sp,
                  height: 10.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditEndDate() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/clock_icon.png",
                width: 22.w,
                height: 22.h,
              ),
              SizedBox(width: 8.w),
              AutoSizeText(
                "완료일",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              _showBottomDateFieldSheet();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray15,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    TextUtils.canParseDateTime(_uiStore.tempBucket!.endDate!) &&
                            _uiStore.tempBucket!.endDate!.isNotEmpty
                        ? "${DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(_uiStore.tempBucket!.endDate!))} 까지"
                        : "완료일이 없습니다",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      Bucket bucket = Bucket(
                        id: _uiStore.tempBucket!.id,
                        title: _uiStore.tempBucket!.title,
                        body: _uiStore.tempBucket!.body,
                        category: _uiStore.tempBucket!.category,
                        endDate: "null",
                        isCompleted: _uiStore.tempBucket!.isCompleted,
                      );

                      _uiStore.tempBucket = bucket;
                    },
                    child: Image.asset(
                      "assets/icons/x_icon.png",
                      width: 10.sp,
                      height: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                if (_uiStore.newBucketEndDate.isNotEmpty) {
                  Bucket bucket = Bucket(
                    id: _uiStore.tempBucket!.id,
                    title: _uiStore.tempBucket!.title,
                    body: _uiStore.tempBucket!.body,
                    category: _uiStore.tempBucket!.category,
                    endDate: _uiStore.newBucketEndDate,
                    isCompleted: _uiStore.tempBucket!.isCompleted,
                  );

                  _uiStore.tempBucket = bucket;
                }
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

  void _showDeleteBucketConfirmDialog() {
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
                "버킷을 삭제하면 다시 되돌릴 수 없어요.",
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
                _userStore!.deleteBucket(
                  spaceId: widget.space.id,
                  bucketId: _uiStore.tempBucket!.id,
                );

                await _userStore!.getBucketList(
                  spaceId: widget.item.id,
                  categoryId: "",
                  state: 0,
                );
                widget.onDelete();
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "버킷 삭제",
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

  void _showBottomCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.95,
      ),
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        child: _buildBottomCategorySheet(context),
      ),
    );
  }

  Widget _buildBottomCategorySheet(BuildContext context) {
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
                "카테고리 선택",
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
          InkWell(
            onTap: () {
              _showNewCategoryBottomSheet(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 20.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.plus,
                    color: AppColors.primary1,
                  ),
                  SizedBox(width: 8.w),
                  AutoSizeText(
                    "새 카테고리",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Observer(builder: (context) {
              return Column(
                children: [
                  ...List.generate(
                    _userStore!.categories.length,
                    (index) {
                      Category category = _userStore!.categories[index];
                      return InkWell(
                        onTap: () {
                          _uiStore.tempSelectedCategory =
                              _userStore!.categories[index];
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                category.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryBlack,
                                ),
                              ),
                              CustomCircleCheckbox(
                                isChecked: _uiStore.tempSelectedCategory == null
                                    ? category.id ==
                                        _uiStore.tempBucket!.category
                                    : category == _uiStore.tempSelectedCategory,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
          DefaultFlatButton(
            onPressed: () {
              Bucket bucket = Bucket(
                id: _uiStore.tempBucket!.id,
                title: _uiStore.tempBucket!.title,
                body: _uiStore.tempBucket!.body,
                category: _uiStore.tempSelectedCategory!.id,
                endDate: _uiStore.tempBucket!.endDate,
                isCompleted: _uiStore.tempBucket!.isCompleted,
              );

              _uiStore.tempBucket = bucket;
              context.router.pop();
            },
            child: AutoSizeText(
              "완료",
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
                          spaceId: widget.space.id,
                          title: _uiStore.editingCategoryName,
                        );

                        if (res != null) {
                          if (res is DioError) {
                            context.router.pop();
                            _showToast(res.error.toString());
                          } else if (res.data["message"] ==
                              "같은 이름의 카테고리가 이미 존재합니다.") {
                            context.router.pop();
                            _showToast("같은 이름의 카테고리가 이미 존재합니다.");
                          } else {
                            context.router.pop();
                            _showToast("새 카테고리를 만들었어요.");
                            await _userStore!
                                .getCategoryList(spaceId: widget.space.id);
                          }
                          _uiStore.setNewBucketDetailCategory("");
                          _newCategoryController.clear();
                          _uiStore.editingCategoryName = "";
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
