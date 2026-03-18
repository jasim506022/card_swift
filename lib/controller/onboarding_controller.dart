import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:card_swift/data/onboarding_list_data.dart';
import 'package:card_swift/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);

  var currentIndex = 0.obs;

  // Why need this ()
  var onboardingList = OnboardingListData.getOnboardingData();

  bool get isLastPage => currentIndex.value == onboardingList.length - 1;

  void completeOnboarding() {
    AppsConstant.isViewed = true;
    AppsConstant.sharedPreferences!.setBool(
      AppString.onboardSharePrefer,
      AppsConstant.isViewed,
    );

    Get.offNamed(RouteName.signPage);
  }

  void updateIndex(int index) => currentIndex.value = index;

  /// Navigates to the next page in the onboarding sequence
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
}
