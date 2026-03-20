import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/style/app_colors.dart';
import '../../common/style/app_string.dart';
import '../../controller/onboarding_controller.dart';
import 'widget/onboarding_widget.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildPageView());
  }

  /// AppBar UI
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(AppString.appName),
      actions: [
        TextButton(
          onPressed: controller.completeOnboarding,
          style: TextButton.styleFrom(foregroundColor: AppColors.green),
          child: const Text(AppString.skipBtn),
        ),
      ],
    );
  }

  /// PageView for onboarding screens
  Widget _buildPageView() {
    return PageView.builder(
      controller: controller.pageController,
      itemCount: controller.onboardingList.length,
      onPageChanged: controller.updateIndex,
      itemBuilder: (_, index) {
        final item = controller.onboardingList[index];
        return OnboardingWidget(onboardingModel: item);
      },
    );
  }
}
