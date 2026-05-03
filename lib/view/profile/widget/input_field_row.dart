import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style/app_colors.dart';

class InputFieldRow extends StatelessWidget {
  const InputFieldRow({super.key, required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.black.withValues(alpha: .45), size: 45.h),
          SizedBox(width: 20.w),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
// Why use const
