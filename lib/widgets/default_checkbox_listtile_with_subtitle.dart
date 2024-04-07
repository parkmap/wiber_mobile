import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wiber_mobile/widgets/custom_circle_checkbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/colors.dart';

class DefaultCheckboxListTileWithSubtitle extends StatefulWidget {
  final bool checkboxValue;
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final bool isChecked;
  final Widget? trailing;

  const DefaultCheckboxListTileWithSubtitle({
    Key? key,
    required this.checkboxValue,
    required this.onTap,
    required this.title,
    required this.subTitle,
    this.isChecked = false,
    this.trailing,
  }) : super(key: key);

  @override
  State<DefaultCheckboxListTileWithSubtitle> createState() =>
      _DefaultCheckboxListTileWithSubtitleState();
}

class _DefaultCheckboxListTileWithSubtitleState
    extends State<DefaultCheckboxListTileWithSubtitle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 12.w,
        ),
        child: Row(
          children: [
            CustomCircleCheckbox(
              isChecked: widget.isChecked,
            ),
            SizedBox(width: 13.w),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.title,
                        style: widget.isChecked
                            ? TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.tertiaryBlack,
                              )
                            : TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlack,
                              ),
                      ),
                      SizedBox(height: 4.h),
                      AutoSizeText(
                        widget.subTitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.tertiaryBlack,
                        ),
                      ),
                    ],
                  ),
                  widget.trailing ??
                      FaIcon(
                        FontAwesomeIcons.ellipsis,
                        color: AppColors.gray70,
                        size: 13.sp,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
