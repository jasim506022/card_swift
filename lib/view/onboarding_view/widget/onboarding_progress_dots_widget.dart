import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/style/app_colors.dart';
import '../../../controller/onboarding_controller.dart';

/// Widget that shows a row of progress dots for onboarding screens.
/// The active dot grows in size and changes color.
class OnboardingProgressDotsWidget extends GetView<OnboardingController> {
  const OnboardingProgressDotsWidget({super.key});

  int get totalDots => controller.onboardingList.length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) => _buildDot(index)),
    );
  }

  /// Builds an individual dot

  Widget _buildDot(int index) {
    return Obx(() {
      final isActive = controller.currentIndex.value == index;
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
    });
  }
}
