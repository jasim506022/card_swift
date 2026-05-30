import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'binding/initial_binding.dart';
import 'common/style/app_colors.dart';
import 'common/style/app_text_style.dart';
import 'route/app_page.dart';
import 'route/route_name.dart';

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
          theme: _appTheme(),
          initialRoute: RouteName.splash,
          getPages: AppPage.pages,
        );
      },
      splitScreenMode: true,
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
    );
  }
}
