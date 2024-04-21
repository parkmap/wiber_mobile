import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';

class CustomCircleCheckbox extends StatefulWidget {
  const CustomCircleCheckbox({
    Key? key,
    this.width,
    this.height,
    this.checkWidth,
    this.checkHeight,
    this.color,
    this.isChecked = false,
    this.checkColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? checkWidth;
  final double? checkHeight;
  final Color? color;
  final Color? checkColor;
  final bool isChecked;

  @override
  State<CustomCircleCheckbox> createState() => _CustomCircleCheckboxState();
}

class _CustomCircleCheckboxState extends State<CustomCircleCheckbox> {
  @override
  Widget build(BuildContext context) {
    return widget.isChecked
        ? Image.asset(
            "assets/images/checked_image.png",
            width: 22.w,
            height: 22.h,
          )
        : Container(
            width: widget.width ?? 22.w,
            height: widget.height ?? 22.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color ?? AppColors.gray30,
                width: 1.w,
              ),
            ),
          );
  }
}
