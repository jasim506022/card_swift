import 'package:card_swift/common/style/app_colors.dart';

import 'package:flutter/material.dart';
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
      appBar: _appBar(),
      body: _pageView(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(AppString.appName, style: AppTextStyle.appBarTitle),
      actions: [
        TextButton(
          // onPressed: () => controller.completeOnboarding(),
          onPressed: controller.completeOnboarding,
          child: Text(
            AppString.skipBtn,
            style: AppTextStyle.button.copyWith(color: AppColors.green),
          ),
        ),
      ],
    );
  }

  PageView _pageView() {
    return PageView.builder(
      // Where find controller
      controller: controller.pageController,
      itemCount: controller.onboardingList.length,
      onPageChanged: controller.updateIndex,
      // onPageChanged: (index) => controller.updateIndex(index),
      itemBuilder: (_, index) {
        // Why use_ here
        final item = controller.onboardingList[index];
        return OnboardingWidget(onboardingModel: item);
      },
    );
  }
}
