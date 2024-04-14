import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../constants/colors.dart';

class DefaultFlatButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final Color? buttonColor;
  final BorderSide? borderSide;
  final double? borderRadius;
  final bool detectKeyboard;
  final bool isKeyboardVisible;
  final EdgeInsets? containerPadding;

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
    this.detectKeyboard = false,
    this.isKeyboardVisible = false,
    this.containerPadding,
  }) : super(key: key);

  @override
  State<DefaultFlatButton> createState() => _DefaultFlatButtonState();
}

class _DefaultFlatButtonState extends State<DefaultFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.detectKeyboard
          ? widget.isKeyboardVisible
              ? EdgeInsets.zero
              : widget.containerPadding ??
                  EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 30.h,
                  )
          : widget.containerPadding ?? EdgeInsets.zero,
      width: widget.width ?? double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.onPressed == null
              ? AppColors.gray40
              : widget.buttonColor ?? AppColors.primary2,
          shape: RoundedRectangleBorder(
            borderRadius: widget.detectKeyboard && widget.isKeyboardVisible
                ? BorderRadius.circular(0)
                : BorderRadius.circular(widget.borderRadius ?? 12.r),
          ),
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.8),
          padding: widget.padding ?? EdgeInsets.symmetric(vertical: 20.h),
          side: widget.borderSide,
        ),
        child: widget.child,
      ),
    );
  }
}
