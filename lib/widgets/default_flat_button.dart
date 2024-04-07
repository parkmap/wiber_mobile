import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class DefaultFlatButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final Color? buttonColor;
  final BorderSide? borderSide;
  final double? borderRadius;

  const DefaultFlatButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.fontWeight = FontWeight.w500,
    this.buttonColor,
    this.borderSide,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null
              ? AppColors.gray20
              : buttonColor ?? AppColors.primary2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.8),
          padding: padding ?? EdgeInsets.symmetric(vertical: 20.h),
          side: borderSide,
        ),
        child: child,
      ),
    );
  }
}
