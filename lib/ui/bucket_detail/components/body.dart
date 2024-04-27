import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/stores/bucket_ui/bucket_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/custom_circle_checkbox.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';

class Body extends StatefulWidget {
  final WiberSpace space;
  final Bucket item;
  final VoidCallback onDelete;

  const Body({
    Key? key,
    required this.space,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  BucketUIStore _uiStore = BucketUIStore();
  TextEditingController _newCategoryController = TextEditingController();
  late FocusNode _newCategoryFocusNode;

  @override
  void initState() {
    super.initState();
    _uiStore = BucketUIStore();
    _newCategoryFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>()..getCategories();

    if (_userStore != userStore) {
      _userStore = userStore;
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
                onTap: () {
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
                onTap: () {
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

  Widget _buildNormalTopBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16.sp * (widget.space.participants.length + 1),
            height: 28.sp,
            child: Indexer(
              alignment: AlignmentDirectional.centerEnd,
              clipBehavior: Clip.none,
              children: [
                const SizedBox.shrink(),
                ...List.generate(
                  widget.space.participants.length,
                  (index) => Indexed(
                    index: -index,
                    child: Positioned(
                      left: 15.sp * index,
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
                          widget.space.participants[index].profileImageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          AutoSizeText(
            widget.item.title,
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
                  widget.item.category,
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
            initialValue: widget.item.title,
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
            onChanged: (value) {},
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
                    widget.item.category,
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
              widget.item.body,
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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray15,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Flexible(
              child: TextFormField(
                autofocus: false,
                initialValue: widget.item.body,
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
                onChanged: (value) {},
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
          GestureDetector(
            onTap: () {},
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
                    "${widget.item.endDate} 까지",
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
            onTap: () {},
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
                    widget.item.endDate,
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
          ),
        ],
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
            child: Column(
              children: [
                ...List.generate(
                  _userStore!.categories.length,
                  (index) {
                    String category = _userStore!.categories[index];
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              category,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlack,
                              ),
                            ),
                            CustomCircleCheckbox(
                              isChecked: category == widget.item.category,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          DefaultFlatButton(
            onPressed: () {},
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
              onPressed: () {},
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
  }
}
