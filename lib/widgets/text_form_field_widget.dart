import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmitted;
  final String hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final List<TextInputMask>? maskFormatterList;
  final List<TextInputFormatter>? inputFormatterList;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final EdgeInsets? contentPadding;
  final bool isOutlined;
  final bool readOnly;
  final InputBorder? inputBorder;
  final InputBorder? focusedInputBorder;
  final bool hideBorder;
  final bool enabled;
  final bool autoFocus;
  final TextAlign? textAlign;
  final bool isDense;
  final Color cursorColor;
  final bool? fill;
  final Color? fillColor;
  final bool rounded;

  const TextFormFieldWidget({
    Key? key,
    required this.onChanged,
    this.onFieldSubmitted,
    this.hintStyle,
    this.hintText = '',
    this.errorText,
    this.style,
    this.keyboardType,
    this.isPassword = false,
    this.textInputAction,
    this.onEditingComplete,
    this.initialValue,
    this.maxLength,
    this.maxLines = 1,
    this.maskFormatterList,
    this.inputFormatterList,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.suffixTextStyle,
    this.contentPadding,
    this.isOutlined = false,
    this.readOnly = false,
    this.enabled = true,
    this.inputBorder,
    this.focusedInputBorder,
    this.hideBorder = false,
    this.focusNode,
    this.textController,
    this.autoFocus = false,
    this.textAlign,
    this.isDense = false,
    this.cursorColor = AppColors.primary1,
    this.fill = true,
    this.fillColor = AppColors.gray20,
    this.rounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? formatterList;
    if (inputFormatterList != null) {
      formatterList = inputFormatterList;
    } else if (maskFormatterList != null) {
      formatterList = maskFormatterList;
    }

    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      inputFormatters: formatterList,
      maxLength: maxLength,
      readOnly: readOnly,
      autofocus: autoFocus,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            color: AppColors.inputBlack,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
      obscureText: isPassword,
      textAlign: textAlign ?? TextAlign.start,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        isDense: isDense,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minHeight: 10,
          minWidth: 10,
        ),
        suffix: suffix,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: AppColors.inputBlack,
          fontSize: 14.sp,
        ),
        suffixText: suffixText,
        suffixStyle: suffixTextStyle,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: AppColors.gray50,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
        counterText: '',
        errorText: errorText,
        border: inputBorder == null
            ? rounded
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  )
                : InputBorder.none
            : inputBorder,
        enabledBorder: inputBorder == null
            ? rounded
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  )
                : InputBorder.none
            : inputBorder,
        focusedBorder: focusedInputBorder == null
            ? rounded
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  )
                : InputBorder.none
            : focusedInputBorder,
        filled: fill,
        fillColor: fillColor,
      ),
    );
  }
}
