import 'package:card_swift/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    this.onTap,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: AppColors.blue, width: 2),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.medium.copyWith(color: textColor),
      ),
    );
  }
}
