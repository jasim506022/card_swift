import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../common/style/app_colors.dart';
import '../../common/style/app_string.dart';
import '../../common/widget/custom_app_bar.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../profile/widget/app_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    final TextEditingController _emailController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppString.passwordHint),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AuthHeader(title: AppString.passwordHint),
            SizedBox(height: 20.h),
            CustomTextFormField(
              controller: _emailController,
              label: "Email",
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30.h),
            AppButton(
              textColor: Colors.white,

              title: "Send Reset Email",
              // isLoading: _authController.isLoading,
              onTap: () => _authController.resetPassword(_emailController.text.trim()), bgColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}