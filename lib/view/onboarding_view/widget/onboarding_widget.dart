import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/style/app_string.dart';
import '../../../common/style/app_text_style.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../model/onboarding_model.dart';
import '../../../common/widget/app_button.dart';
import 'onboarding_progress_dots_widget.dart';

class OnboardingWidget extends GetView<OnboardingController> {
  const OnboardingWidget({super.key, required this.onboardingModel});

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Top image
          SizedBox(
            height: 0.35.sh,
            width: 1.sw,
            child: Image.asset(onboardingModel.image, fit: BoxFit.contain),
          ),
          // Progress indicator (dots)
          const OnboardingProgressDotsWidget(),
          // Title and description
          Column(
            children: [
              Text(
                onboardingModel.title,
                style: AppTextStyle.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Text(
                onboardingModel.description,
                textAlign: TextAlign.center,
                style: AppTextStyle.body.copyWith(height: 1.5),
              ),
            ],
          ),

          Obx(() {
            return AppButton(
              title: controller.isLastPage
                  ? AppString.finishBtn
                  : AppString.nextBtn,
              onTap: () => controller.goToNextPageOrSkip(),
            );
          }),
        ],
      ),
    );
  }
}
