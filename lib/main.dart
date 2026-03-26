import 'dart:developer' as developer;
import 'package:card_swift/binding/initial_binding.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/route/app_page.dart';
import 'package:card_swift/route/route_name.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'common/style/app_colors.dart';
import 'common/style/apps_constant.dart';
import 'common/style/app_string.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Why need to Here use Async and await and Future
  // Why use WidgetsFlutterBinding.ensureInitialized(); this:
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize Firebase
  await _initializeFirebase();
  // Load shared preferences and onboarding status
  await _loadSharedPreferences();
  runApp(const MyApp());
}

/// Firebase Initialization with error handling
/// Why use _ underscore and private
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stackTrace) {
    developer.log("Firebase initialization failed: $e", stackTrace: stackTrace);
  }
}

/// Firebase Initialization with error handling
/// Understand this code
Future<void> _loadSharedPreferences() async {
  try {
    // Please Describe  this code
    AppsConstant.sharedPreferences = await SharedPreferences.getInstance();
    // Check onboarding status
    AppsConstant.isViewed =
        AppsConstant.sharedPreferences?.getBool(AppString.onboardSharePrefer) ??
        false;
  } catch (e, stackTrace) {
    developer.log(
      "Error loading SharedPreferences: $e",
      stackTrace: stackTrace,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 752),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.white,
              contentTextStyle: AppTextStyle.body,
              titleTextStyle: AppTextStyle.appBarTitle,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(AppTextStyle.button),
                foregroundColor: WidgetStatePropertyAll(AppColors.black),
                // Border color & width
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            textTheme: TextTheme(
              bodyMedium: AppTextStyle.body,
              labelMedium: AppTextStyle.bodyTitle,

            ),

            scaffoldBackgroundColor: AppColors.white,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              titleTextStyle: AppTextStyle.appBarTitle,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              iconTheme: IconThemeData(color: AppColors.black, size: 25.h),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: AppTextStyle.button,
                foregroundColor: AppColors.black,
              ),
            ),
          ),
          initialRoute: RouteName.splash,
          getPages: AppPage.pages,
        );
      },
      splitScreenMode: true,
    );
  }
}
