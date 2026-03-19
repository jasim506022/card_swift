import 'package:card_swift/common/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';

class OnboardingProgressDotsWidget extends GetView<OnboardingController> {
  const OnboardingProgressDotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // Understand Code This
      children: List.generate(
        4,
        (index) => Obx(() {
          bool isActive = controller.currentIndex.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 8.h,
            width: isActive ? 16.h : 8.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: isActive ? AppColors.red : AppColors.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
          );
        }),
      ),
    );
  }
}
