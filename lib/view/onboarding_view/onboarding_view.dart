import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/data/onboarding_list_data.dart';
import 'package:card_swift/view/profile/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../controller/onboarding_controller.dart';
import 'widget/onboarding_widget.dart';

// Why no need stateless widget
class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(AppString.appName, style: AppTextStyle.appBarTitle),
        actions: [
          TextButton(
            onPressed: () => controller.completeOnboarding(),
            child: Text(
              AppString.skipBtn,
              style: AppTextStyle.button.copyWith(color: Color(0xFF004704)),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        // Where find controller
        controller: controller.pageController,
        itemCount: controller.onboardingList.length,
        onPageChanged: (index) => controller.updateIndex(index),
        itemBuilder: (context, index) {
          final onboardingModel = controller.onboardingList[index];
          return OnboardingWidget(onboardingModel: onboardingModel);
        },
      ),
    );
  }
}
