import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_assets.dart';
import '../../common/style/app_colors.dart';
import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../common/style/app_validator.dart';
import '../../common/widget/app_clickable_text.dart';
import '../../common/widget/social_button.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../common/widget/app_button.dart';
import '../../route/route_name.dart';
import 'widget/auth_layout.dart';

/// Sign In Page with Email/Password login, social login, and navigation to Sign Up / Forgot Password.

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthController _authController;

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          _authController.confirmExitApp(),
      child: AuthLayout(
        title: AppString.signIn,
        showBackButton: false,
        children: [
          _buildForm(),
          SizedBox(height: 20.h),

          // Sign In Button with loading state
          AppButton(
            isLoading: _authController.isLoading,
            width: 1.sw,
            title: AppString.signIn,
            onTap: _handleSignIn,
          ),

          SizedBox(height: 15.h),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed(RouteName.passwordPage),
              child: Text(
                AppString.forgetPassword,
                style: AppTextStyle.button.copyWith(
                  color: AppColors.black.withValues(alpha: .5),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),

          // Social Login Section
          _buildSocialDivider(),
          SizedBox(height: 24.h),

          /// Social login buttons (Google, Apple, Facebook)
          _buildSocialButtons(),
          SizedBox(height: 40.h),
          Center(
            child: AppClickableText(
              onTap: () => Get.toNamed(RouteName.signUpPage),
              prefixText: AppString.doNotHaveAccount,
              linkText: AppString.signUp,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Facebook
        SocialButton(
          onTap: _authController.signInGoogle,
          icon: AppAssets.googleIcon,
        ),
        // Google
        SocialButton(onTap: () {}, icon: AppAssets.appleIcon),
        // Apple
      ],
    );
  }

  Row _buildSocialDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(AppString.loginWith, style: AppTextStyle.inputLabel),
        ),
        const Expanded(child: Divider()),
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
            validator: AppValidator.validateEmail,
          ),

          // Password Field
          CustomTextFormField(
            label: AppString.passwordLabel,
            hintText: AppString.passwordHint,
            controller: _passwordController,
            obscureText: true,
            hasPasswordToggle: true,
            // validator: AppValidator.validatePassword,
          ),
        ],
      ),
    );
  }

  /// Handle SignUp
  Future<void> _handleSignIn() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await _authController.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
