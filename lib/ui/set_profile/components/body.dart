import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/stores/set_profile/set_profile_store.dart';
import 'package:wiber_mobile/stores/user/user_store.dart';
import 'package:wiber_mobile/widgets/default_bottom_dialogue.dart';
import 'package:wiber_mobile/widgets/default_flat_button.dart';

class Body extends StatefulWidget {
  final String nickname;
  const Body({
    required this.nickname,
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserStore? _userStore;
  SetProfileStore _setProfileStore = SetProfileStore();
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _setProfileStore = SetProfileStore();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final userStore = context.read<UserStore>()
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
      child: Observer(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 24.h,
                  left: 20.w,
                  right: 20.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "프로필을 설정해주세요",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray90,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AutoSizeText(
                      "언제든지 프로필 사진을 바꿀 수 있어요.",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tertiaryBlack,
                      ),
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
                                      child:
                                          _setProfileStore.profileImage == null
                                              ? Image.asset(
                                                  _setProfileStore
                                                      .defaultProfilePath,
                                                  width: 120.sp,
                                                  height: 120.sp,
                                                )
                                              : Image.file(
                                                  File(_setProfileStore
                                                      .profileImage!.path),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              child: DefaultFlatButton(
                onPressed: () async {
                  var res = await _userStore!.createUser(
                    username: widget.nickname,
                  );

                  if (res != null &&
                      res["id"] != null &&
                      res["message"] == null) {
                    await _userStore?.saveUserId(userId: res["id"]);

                    if (_setProfileStore.profileImage != null) {
                      final MultipartFile profileImage =
                          MultipartFile.fromFileSync(
                        _setProfileStore.profileImage!.path,
                        contentType: MediaType("image", "jpg"),
                      );

                      await _userStore?.saveProfileImage(
                        profileImage: profileImage,
                      );
                    }
                  }
                  // context.router.replaceAll([
                  //   const HomeRoute(),
                  // ]);
                },
                child: _userStore!.isCreatingUser
                    ? Image.asset(
                        "assets/images/loading_spinner.gif",
                        width: 20.sp,
                        height: 20.sp,
                      )
                    : AutoSizeText(
                        "시작하기",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        );
      }),
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
                  // final croppedFile = await ImageCropper().cropImage(
                  //   sourcePath: image.path,
                  //   compressFormat: ImageCompressFormat.jpg,
                  //   compressQuality: 100,
                  //   cropStyle: CropStyle.circle,
                  //   maxHeight: 100,
                  //   maxWidth: 100,
                  //   aspectRatio:
                  //       const CropAspectRatio(ratioX: 0.3, ratioY: 0.3),
                  //   uiSettings: [
                  //     AndroidUiSettings(
                  //       toolbarColor: Colors.black,
                  //       lockAspectRatio: true,
                  //     ),
                  //     IOSUiSettings(
                  //       title: 'Cropper',
                  //     ),
                  //   ],
                  // );
                  _setProfileStore.setProfileImage(image);
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
                _setProfileStore.resetProfileImage();
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
}
