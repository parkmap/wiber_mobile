import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/router/router.gr.dart';
import 'package:wiber_mobile/stores/setting_ui/setting_ui_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';
import 'package:wiber_mobile/widgets/loading_spinner.dart';
import 'package:wiber_mobile/widgets/text_form_field_widget.dart';
import 'package:image/image.dart' as img;

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  SettingUiStore _uiStore = SettingUiStore();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nicknameController = TextEditingController();
  late FocusNode _nicknameFocusNode;
  FToast fToast = FToast();

  @override
  void initState() {
    _uiStore = SettingUiStore();
    _nicknameFocusNode = FocusNode();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>();

    if (_userStore != userStore) {
      _userStore = userStore;
    }

    _nicknameController.text = _userStore!.user!.nickname;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTopBar(),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 8.h,
                  color: AppColors.gray15,
                ),
                _buildBottomItems(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
              ),
              child: Observer(builder: (context) {
                return DefaultFlatButton(
                  onPressed: _nicknameController.text.isEmpty ||
                          _uiStore.isUpdatingUserInfo
                      ? null
                      : () async {
                          _uiStore.toggleIsUpdatingUserInfo();
                          if (_uiStore.profileImage != null) {
                            Uint8List imageBytes =
                                await _uiStore.profileImage!.readAsBytes();
                            img.Image? originalImage =
                                img.decodeImage(imageBytes);

                            if (originalImage != null) {
                              img.Image resizedImage = img.copyResize(
                                  originalImage,
                                  width: 300,
                                  height: 300);
                              Uint8List jpegImageBytes = Uint8List.fromList(
                                  img.encodeJpg(resizedImage, quality: 85));

                              await _userStore?.saveProfileImage(
                                profileImage: jpegImageBytes,
                              );
                            }
                          }

                          await _userStore?.updateUserInfo(
                            userNickname: _nicknameController.text,
                            pushToken: "test",
                          );

                          await _userStore?.refreshUserInfo();

                          _showToast("프로필이 변경되었습니다.");
                          try {} catch (error) {
                            print(error);
                          } finally {
                            _uiStore.toggleIsUpdatingUserInfo();
                          }
                        },
                  child: _uiStore.isUpdatingUserInfo
                      ? LoadingSpinner()
                      : AutoSizeText(
                          "저장",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                );
              }),
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
                  context.router.pop();
                },
                child: Image.asset(
                  'assets/icons/chevron_left_icon.png',
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
                      child: Image.asset(
                        'assets/icons/setting_icon.png',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 135.sp,
                height: 135.sp,
                child: GestureDetector(
                  onTap: () {
                    showSetProfileDialogue();
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            width: 135.sp,
                            height: 135.sp,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: _uiStore.profileImage == null
                                ? _userStore!.user!.profileImageUrl.isEmpty
                                    ? Image.asset(
                                        "assets/images/default_profile_image.png",
                                        width: 120.sp,
                                        height: 120.sp,
                                      )
                                    : Image.network(
                                        _userStore!.user!.profileImageUrl,
                                        width: 120.sp,
                                        height: 120.sp,
                                      )
                                : Image.file(
                                    File(_uiStore.profileImage!.path),
                                    width: 120.sp,
                                    height: 120.sp,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 44.sp,
                          height: 44.sp,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gray20,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gray60,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/icons/camera_icon.png",
                              width: 21.sp,
                              height: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              "닉네임",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.gray100,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          TextFormFieldWidget(
            textController: _nicknameController,
            onChanged: (val) {
              _nicknameController.text = val;
            },
            focusNode: _nicknameFocusNode,
            hintText: "닉네임을 입력해주세요",
            maxLength: 6,
            suffixActions: () {
              _nicknameController.text = "";
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomItems() {
    return Flexible(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                "내가 참여중인 위버스페이스",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray100,
                ),
              ),
              ...List.generate(_userStore!.wiberSpaceList.length, (index) {
                WiberSpace space = _userStore!.wiberSpaceList[index];
                return InkWell(
                  onTap: () {
                    _showSpaceDeleteConfirmDialog(space);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 12.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray15,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          space.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void showSetProfileDialogue() {
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
                "프로필 사진 선택",
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
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  _uiStore.setProfileImage(image);
                  context.router.pop();
                }
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "앨범에서 사진 선택",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary2,
                  ),
                ),
              ),
            ),
            Divider(
              height: 0.2.sp,
              thickness: 0.2.sp,
              color: AppColors.gray10,
            ),
            InkWell(
              onTap: () {
                _uiStore.resetProfileImage();
                context.router.pop();
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AutoSizeText(
                  "기본 이미지로 변경",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary2,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _showSpaceDeleteConfirmDialog(WiberSpace item) {
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
                _showToast("${item.title} 스페이스가 삭제되었습니다.");
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
