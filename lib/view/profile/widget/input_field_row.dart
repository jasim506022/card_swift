import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_text_style.dart';

class InputFieldRow extends StatelessWidget {
  const InputFieldRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.black.withValues(alpha: .45), size: 30.h),
          SizedBox(width: 15.w),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.grey[300]!, width: 1.w),
              ),
              child: Text(
                text,
                style: AppTextStyle.inputLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
// Why use const
