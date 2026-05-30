import 'package:card_swift/view/main/main_page.dart';
import 'package:card_swift/view/scan/scan_page.dart';
import 'package:get/get.dart';

import '../view/auth/forget_password_page.dart';
import '../view/auth/sign_in_page.dart';
import '../view/auth/sign_up_page.dart';
import '../view/onboarding_view/onboarding_view.dart';
import '../view/splash/splash_view.dart';
import 'route_name.dart';

class AppPage {
  static List<GetPage> pages = [
    GetPage(name: RouteName.splash, page: () => SplashView()),
    GetPage(name: RouteName.onboarding, page: () => OnboardingView()),
    GetPage(name: RouteName.signPage, page: () => SignInPage()),
    GetPage(name: RouteName.signUpPage, page: () => SignUpPage()),
    GetPage(name: RouteName.passwordPage, page: () => ForgetPasswordPage()),
    GetPage(name: RouteName.mainPage, page: () => MainPage()),
    GetPage(name: RouteName.scanPage, page: () => ScanPage()),
    // GetPage(name: RouteName.homePage, page: () => HomeViewPage()),
  ];
}
