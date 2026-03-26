import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

/// A customizable AppBar with optional title, back button, and actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black.withValues(alpha: .3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Icon(LucideIcons.chevron_left),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
