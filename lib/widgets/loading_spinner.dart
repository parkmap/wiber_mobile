import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/loading_spinner.json",
      width: width ?? 20.sp,
      height: height ?? 20.sp,
    );
  }
}
