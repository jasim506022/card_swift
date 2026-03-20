
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/style/app_string.dart';
import '../common/style/apps_constant.dart';
import '../data/onboarding_list_data.dart';
import '../model/onboarding_model.dart';
import '../route/route_name.dart';

/// Controller for onboarding screens, handling page navigation,
class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);

  final RxInt currentIndex = 0.obs;

  /// Onboarding data list
  final List<OnboardingModel> onboardingList =
      OnboardingListData.getOnboardingData();

  /// Checks if the current page is the last page
  bool get isLastPage => currentIndex.value == onboardingList.length - 1;

  /// Marks onboarding as completed and navigates to sign-in page
  void completeOnboarding() {
    AppsConstant.isViewed = true;
    AppsConstant.sharedPreferences?.setBool(
      AppString.onboardSharePrefer,
      AppsConstant.isViewed,
    );
    // Navigate and remove onboarding from navigation stack
    Get.offNamed(RouteName.signPage);
  }

  /// Updates the current page index (called onPageChanged)
  void updateIndex(int index) => currentIndex.value = index;

  /// Navigates to the next page or completes onboarding if on last page
  void goToNextPageOrSkip() {
    if (isLastPage) {
      completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
