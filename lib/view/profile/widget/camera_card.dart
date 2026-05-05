
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_string.dart';
import '../../../common/style/app_text_style.dart';

class CameraCard extends StatelessWidget {
  const CameraCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.capturePersonalBusinessCard,
          style: AppTextStyle.bodyTitle,
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 25.h),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Column(
            children: [
              Icon(Icons.camera_alt, color: Colors.white, size: 35.h),
              Text(
                AppString.newCard,
                style: AppTextStyle.textBold.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

