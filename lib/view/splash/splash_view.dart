import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_colors.dart';
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
                SizedBox(height: 10.h),
                Text(AppString.loading, style: AppTextStyle.medium),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*
why i can't use const sizeBox and Text
 */


/*
Why doesn't work controller
class SplashView extends GetView<SplashController>
 */

/*
Short answer:


 */

/*
if GetX Controller Doesn't Work: Check:
create the controller ❌
initialize it ❌
run onInit() ❌
 */

/*
Understand of this: Get.lazyPut<SplashController>(() => SplashController()); and
Why use Binding and beneficial of this this binding
 */
/*
if use: Getx Avoid to use Navigator.push(....) . Use Get.to(SplashView());
 */

/*
Good — this actually tells us exactly where the problem is 👍
If Get.find<SplashController>() works, but GetView<SplashController> doesn’t trigger the controller, then:

🔴 Your controller is registered, but never accessed automatically

if you never use controller, then:

Get.lazyPut() stays lazy 😴

Controller is never created

onInit() is never called
 */

/*
When use GetBuilder and Beneficial of use this and difference between other
 */
