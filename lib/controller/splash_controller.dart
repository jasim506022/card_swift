import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common/style/apps_constant.dart';
import '../repository/splash_repository.dart';
import '../route/route_name.dart';

/// `SplashController` handles the logic for the splash page, including navigation
/// and UI configuration. It determines whether the user should go to the main page,
/// onboarding, or sign-in page

class SplashController extends GetxController {
  final SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _configureUi();
  }

  // Can i declare method on below of Super but Why

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _navigateToNextPage();
  }

  // is this method is future
  Future<void> _navigateToNextPage() async =>
      await Future.delayed(Duration(seconds: 2), () {
        final user = repository.currentUser();
        final targetRoute = _resolveRoute(user);
        /*
        String targetRoute = (user != null)
            ? "Home Page"
            : AppsConstant.isViewed
            ? RouteName.signPage
            : RouteName.onboarding;


         */
        Get.offNamed(targetRoute);
      });

  // Instead of this but why its best
  String _resolveRoute(User? user) {
    if (user != null) return "RouteName.home";

    if (AppsConstant.isViewed) {
      return RouteName.signPage;
    }

    return RouteName.onboarding;
  }

  void _configureUi() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.onClose();
  }
}
