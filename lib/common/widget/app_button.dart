import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

/// A reusable button widget with optional loading state, custom colors, and size.
/// Uses ElevatedButton for Material compliance.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.bgColor,
    this.textColor,
    required this.onTap,
    this.borderColor,
    this.width,
    this.height,
    this.isLoading,
  });

  final String title;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback onTap;
  final Color? borderColor;
  final RxBool? isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // If isLoading is provided, listen to changes with Obx
    if (isLoading != null) {
      return Obx(() => _buildButton(isLoading!.value));
    } else {
      // Default button without loading
      return _buildButton(false);
    }
  }

  /// Builds the actual ElevatedButton widget
  ElevatedButton _buildButton(bool loading) {
    return ElevatedButton(
      onPressed: () {
        if (!loading) onTap();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width == null ? 0 : width!, height ?? 50.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
        // Colors
        backgroundColor: bgColor ?? AppColors.black,
        foregroundColor: textColor ?? AppColors.white,

        side: BorderSide(
          color: borderColor == null
              ? (bgColor ?? AppColors.black)
              : borderColor!,
          width: 2.w,
        ),

        textStyle: AppTextStyle.button,
      ),

      child: loading
          ? CircularProgressIndicator(
              backgroundColor: AppColors.black,
              color: AppColors.white,
              strokeWidth: 2,
            )
          : Text(title),
    );
  }
}
