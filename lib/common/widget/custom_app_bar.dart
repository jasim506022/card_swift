import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

/// A customizable AppBar with optional title, back button, and actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.white,
      //title!
      title: title != null ? Text(title!, style: AppTextStyle.title) : null,
      // leadingWidth: 56.w, fds
      leading: showBackButton ? _buildBackButton() : null,
      actions: actions,
    );
  }

  /// Back button widget with default Get.back() action
  Padding _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, top: 8.h, bottom: 8.h),
      child: InkWell(
        onTap: onBackPressed ?? Get.back,
        // Cleaner syntax. No need for () => since Get.back is already a callable function.
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withValues(alpha: .3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Icon(
            LucideIcons.chevron_left,
            color: AppColors.blue,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// What is difference between Background color and foregroundColor