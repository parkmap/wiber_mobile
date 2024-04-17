import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';

import '../constants/colors.dart';

class WiberSpaceListTile extends StatefulWidget {
  final WiberSpace item;
  final bool isOwner;

  const WiberSpaceListTile({
    Key? key,
    required this.item,
    required this.isOwner,
  }) : super(key: key);

  @override
  State<WiberSpaceListTile> createState() => _WiberSpaceListTileState();
}

class _WiberSpaceListTileState extends State<WiberSpaceListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                widget.item.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlack,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.item.isFavorite
                        ? "assets/icons/favorite_on_icon.png"
                        : "assets/icons/favorite_off_icon.png",
                    width: 24.sp,
                    height: 24.sp,
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
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
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.none,
                children: [
                  ...List.generate(
                    widget.item.participants.length,
                    (index) => Positioned(
                      child: Image.asset(
                        widget.item.participants[index].profileImageUrl,
                        width: 28.sp,
                        height: 28.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.item.isFavorite
                        ? "assets/icons/favorite_on_icon.png"
                        : "assets/icons/favorite_off_icon.png",
                    width: 24.sp,
                    height: 24.sp,
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
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
        ],
      ),
    );
  }
}
