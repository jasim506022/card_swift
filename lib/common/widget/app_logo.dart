import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_assets.dart';
import '../style/app_string.dart';
import '../style/app_text_style.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.appIcon, height: 80.h, width: 80.h),
        Text(AppString.appName, style: AppTextStyle.appNameTitle),
      ],
    );
  }
}
