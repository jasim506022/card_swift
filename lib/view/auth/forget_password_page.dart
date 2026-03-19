import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_string.dart';
import '../../common/widget/app_clickable_text.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../common/widget/app_button.dart';
import 'widget/auth_layout.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final AuthController _authController;
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: AppString.forgetPassword,
      children: [
        _buildForm(),
        SizedBox(height: 15.h),
        AppButton(
          title: AppString.sendResetEmailBtn,
          width: 1.sw,
          onTap: () =>
              _authController.resetPassword(_emailController.text.trim()),
        ),

        AppClickableText(
          prefixText: AppString.backTo,
          linkText: AppString.signIn,
          //
          onTap: Get.back,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: CustomTextFormField(
        controller: _emailController,
        label: AppString.emailLabel,
        hintText: AppString.enterYourEmailHint,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }
}

/*
() {
            Get.back();
          }
 */

/*
Scaffold(
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
              onTap: () =>
                  _authController.resetPassword(_emailController.text.trim()),
              bgColor: Colors.black,
            ),
          ],
        ),
      ),
    );
 */

// Why we doesn't use GridView or Stateless
