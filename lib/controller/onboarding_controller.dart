import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:card_swift/data/onboarding_list_data.dart';
import 'package:card_swift/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for onboarding screens, handling page navigation,
/// progress tracking, and completion logic.
class OnboardingController extends GetxController {
  /// Page controller for onboarding PageView
  final PageController pageController = PageController(initialPage: 0);
  /// Current onboarding page index (reactive)

  final RxInt currentIndex = 0.obs;

  // Why need this ()
  /// List of onboarding items
  /// () is needed because getOnboardingData is a **method**, not a property
  var onboardingList = OnboardingListData.getOnboardingData();
  /// Checks if the current page is the last page
  bool get isLastPage => currentIndex.value == onboardingList.length - 1;

  /// Marks onboarding as completed, stores in shared preferences, and navigates
  void completeOnboarding() {
    AppsConstant.isViewed = true;
    AppsConstant.sharedPreferences!.setBool(
      AppString.onboardSharePrefer,
      AppsConstant.isViewed,
    );

    Get.offNamed(RouteName.signPage);
  }

  /// Updates the current page index (called onPageChanged)
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
