import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiber_mobile/constants/colors.dart';
import 'package:wiber_mobile/utils/device_utils.dart';

class CustomAppBarWithBackButton extends StatefulWidget
    implements PreferredSizeWidget {
  final Color? backButtonColor;
  final Color color;
  final dynamic data;
  final VoidCallback? onPressed;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;

  CustomAppBarWithBackButton(
      {Key? key,
      this.title,
      this.titleWidget,
      this.backButtonColor,
      this.color = Colors.white,
      this.data,
      this.onPressed,
      this.actions})
      : preferredSize = Size.fromHeight(45.h),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<CustomAppBarWithBackButton> createState() =>
      _CustomAppBarWithBackButtonState();
}

class _CustomAppBarWithBackButtonState
    extends State<CustomAppBarWithBackButton> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: widget.color,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          DeviceUtils.hideKeyboard(context);
          FocusScope.of(context).unfocus();

          if (widget.onPressed != null) {
            widget.onPressed!();
            return;
          }

          context.router.pop(widget.data);
        },
        iconSize: 26.sp,
        icon: Image.asset(
          'assets/icons/back_icon.png',
        ),
      ),
      title: widget.titleWidget == null && widget.title != null
          ? AutoSizeText(
              widget.title!,
              style: TextStyle(
                color: AppColors.gray90,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            )
          : widget.titleWidget != null
              ? widget.titleWidget
              : null,
      actions: widget.actions,
    );
  }
}
