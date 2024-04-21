import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';

class DefaultDialog extends StatefulWidget {
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Widget children;

  const DefaultDialog({
    Key? key,
    this.contentPadding,
    this.borderRadius,
    required this.children,
  }) : super(
          key: key,
        );

  @override
  _DefaultDialogState createState() => _DefaultDialogState();
}

class _DefaultDialogState extends State<DefaultDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 50.w,
        vertical: 20.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
      ),
      child: Container(
        padding: widget.contentPadding ??
            EdgeInsets.only(
              top: 20.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.w,
            ),
        constraints: BoxConstraints(maxHeight: 200.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
        ),
        child: widget.children,
      ),
    );
  }
}
