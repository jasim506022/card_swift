
import 'package:card_swift/common/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? content;
  final String? buttonText;
  final bool barrierDismissible;

  const ErrorDialogWidget({
    super.key,
    required this.icon,
    required this.title,
    this.content,
    this.buttonText,
    this.barrierDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barrierDismissible ?  Get.back : null,
      child: Dialog(
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_rounded, size: 100.h, color: AppColors.red,),
              // Image.asset(icon, height: 100.h, width: 100.h),
              SizedBox(height: 20.h),
              Text(
                title,
                style: AppTextStyle.subTitle,
                textAlign: TextAlign.center,
              ),
              if (content != null) ...[
                SizedBox(height: 15.h),
                Text(
                  content!,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body,
                ),
              ],
              if (buttonText != null) ...[
                SizedBox(height: 20.h),

                AppButton(title: buttonText!, onTap: Get.back, bgColor: AppColors.red,)
              ],
            ],
          ),
        ),
      ),
    );
  }
}

