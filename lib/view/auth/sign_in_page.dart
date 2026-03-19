import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_assets.dart';
import '../../common/style/app_colors.dart';
import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../common/widget/app_clickable_text.dart';
import '../../common/widget/social_button.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../common/widget/app_button.dart';
import '../../route/route_name.dart';
import 'widget/auth_layout.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Why use Late Here
  late final AuthController _authController;

  // Why use this method

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: AppString.signIn,
      showBackButton: false,
      children: [
        _buildForm(),
        SizedBox(height: 20.h),
        AppButton(width: 1.sw, title: AppString.signIn, onTap: _handleSignIn),
        SizedBox(height: 15.h),
        // 4. Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed(RouteName.passwordPage),
            child: Text(
              AppString.forgetPassword,
              style: AppTextStyle.inputHint.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.grey.withValues(alpha: .5),
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),

        // 6. Social Login Section
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(AppString.loginWith, style: AppTextStyle.inputLabel),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 24.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Facebook
            SocialButton(
              onTap: () => _authController.signInGoogle,
              // _authController.signInGoogle(),
              icon: AppAssets.googleIcon,
            ),
            // Google
            SocialButton(onTap: () {}, icon: AppAssets.appleIcon),
            // Apple
          ],
        ),
        SizedBox(height: 40.h),
        Center(
          child: AppClickableText(
            onTap: () => Get.toNamed(RouteName.signUpPage),
            prefixText: AppString.doNotHaveAccount,
            linkText: AppString.signUp,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          CustomTextFormField(
            label: AppString.emailLabel,
            hintText: AppString.emailHint,
            textInputType: TextInputType.emailAddress,
            controller: _emailController,
          ),

          // Password Field
          CustomTextFormField(
            label: AppString.passwordLabel,
            hintText: AppString.passwordHint,
            controller: _passwordController,
            obscureText: true,
            hasPasswordToggle: true,
          ),
        ],
      ),
    );
  }

  /// Handle SignUp
  Future<void> _handleSignIn() async {
    // understand ths code
    if (!_formKey.currentState!.validate()) return;
    await _authController.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}

/*
Scaffold(
      backgroundColor: AppColors.white,
      // Why use Const
      appBar: const CustomAppBar(
        title: AppString.signIn,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

      ),
    );
 */

/*
When we use Extract Method and Extract Widget
 */
