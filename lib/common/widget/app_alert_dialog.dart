import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';
import '../style/app_function.dart';
import '../style/app_string.dart';
import 'outline_button.dart';

/// A reusable, customizable alert dialog widget with:
/// - A title and an icon in the header.
/// - Content text message.
/// - Two action buttons: Confirm and Cancel with customizable colors and callbacks.
class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirmPressed,
    this.onCancelPressed,
    required this.icon,
    this.iconColor = AppColors.red,
    this.confirmButtonColor = AppColors.red,
    this.cancelButtonColor = AppColors.green,
  });

  final String title;
  final String content;
  final VoidCallback onConfirmPressed;
  final VoidCallback? onCancelPressed;
  final IconData icon;
  final Color iconColor;
  final Color confirmButtonColor;
  final Color cancelButtonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildDialogHeader(),
      content: Text(content),
      actions: _buildActionButtons(),
    );
  }

  /// Builds the alert dialog header with an icon and title.
  Row _buildDialogHeader() {
    return Row(
      children: [
        Text(title),
        // SizedBox(width: 20.w),
        AppFunction.horizontalSpacing(20),
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.white),
        ),
      ],
    );
  }

  /// Builds the list of action buttons: Confirm and Cancel.
  /// Confirm button triggers [onConfirmPressed].
  /// Cancel button triggers [onCancelPressed] or defaults to closing the dialog.
  List<Widget> _buildActionButtons() {
    return [
      OutlinedTextButton(
        color: confirmButtonColor,
        title: AppString.yesBtn,
        onPressed: onConfirmPressed,
      ),
      OutlinedTextButton(
        color: cancelButtonColor,
        title: AppString.noBtn,
        onPressed: onCancelPressed ?? Get.back,
      ),
    ];
  }
}
