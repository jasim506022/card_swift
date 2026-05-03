import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/style/app_colors.dart';
import '../../common/style/app_function.dart';
import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../common/widget/app_logo.dart';
import '../../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                AppFunction.verticalSpacing(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.loading, style: AppTextStyle.bodyTitle),
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.black,
                      size: 40.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
