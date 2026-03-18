import 'package:card_swift/route/route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_colors.dart';
import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../common/widget/custom_app_bar.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../profile/widget/app_button.dart';

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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppString.signIn, showBackButton: false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AuthHeader(title: AppString.signIn),
            SizedBox(height: 20.h), _buildForm(),
            SizedBox(height: 20.h),
            AppButton(
              title: AppString.signIn,
              onTap: _handleSignUp,
              bgColor: Colors.black,
              textColor: Colors.white,
              // onTapWhileLoading: () {
              //   Get.snackbar(
              //     "Please wait",
              //     "Sign in is in progress...",
              //     snackPosition: SnackPosition.BOTTOM,
              //     backgroundColor: Colors.black87,
              //     colorText: Colors.white,
              //   );
              // },
              // isLoading: _authController.isLoading,
            ),

            // 4. Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(RouteName.passwordPage),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // 5. Login Button
            SizedBox(height: 30.h),

            // 6. Social Login Section
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Or Login with",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Facebook
                _socialButton(
                  'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                  () {
                    _authController.signInGoogle();
                  },
                ),
                // Google
                _socialButton(
                  'https://cdn-icons-png.flaticon.com/512/0/747.png',
                  () {},
                ),
                // Apple
              ],
            ),
            SizedBox(height: 40.h),
            _buildLoginFooter(),
          ],
        ),
      ),
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
  Future<void> _handleSignUp() async {
    // understand ths code
    if (!_formKey.currentState!.validate()) return;

    await _authController.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  /// Login footer
  Widget _buildLoginFooter() {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppString.alreadyHaveAccount,
              style: AppTextStyle.body,
            ),
            TextSpan(
              text: AppString.signIn,
              style: AppTextStyle.button.copyWith(
                color: AppColors.blue,
                decoration: TextDecoration.underline,
              ),
              // Understand ths Code
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(RouteName.signUpPage);
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String iconUrl, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: 90.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(child: Image.network(iconUrl, height: 24.h)),
      ),
    );
  }
}
