import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/constants/colors.dart';

class DefaultBottomDialog extends StatefulWidget {
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final double? widgetsPadding;
  final List<Widget> children;
  final Widget? bottomWidget;

  const DefaultBottomDialog({
    Key? key,
    this.contentPadding,
    this.borderRadius,
    this.widgetsPadding,
    required this.children,
    this.bottomWidget,
  }) : super(
          key: key,
        );

  @override
  _DefaultBottomDialogState createState() => _DefaultBottomDialogState();
}

class _DefaultBottomDialogState extends State<DefaultBottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
          top: 20.h,
        ),
        alignment: Alignment.bottomCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Column(
                  children: [
                    ...widget.children,
                  ],
                ),
              ),
              SizedBox(height: widget.widgetsPadding ?? 10.h),
              InkWell(
                onTap: () {
                  context.router.pop(context);
                },
                child: widget.bottomWidget ??
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: AutoSizeText(
                        "취소",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary2,
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ));
  }
}
