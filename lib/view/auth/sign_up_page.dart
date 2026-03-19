import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_string.dart';
import '../../common/widget/app_clickable_text.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../common/widget/app_button.dart';
import 'widget/auth_layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // is Good practice to declare _authController
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late final AuthController _authController;

  /*
  Calling Get.find() inside build() is not recommended because build() can run many times.

Better:
Initialize once in initState().
   */

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: AppString.signUp,
      children: [
        _buildForm(),
        SizedBox(height: 20.h),
        AppButton(title: AppString.signUp, onTap: _handleSignUp, width: 1.sw),
        SizedBox(height: 20.h),
        Center(
          child: AppClickableText(
            // onTap: () => Get.back()
            onTap: Get.back,
            prefixText: AppString.alreadyHaveAccount,
            linkText: AppString.signIn,
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
          // Name Field
          CustomTextFormField(
            label: AppString.nameLabel,
            hintText: AppString.nameHint,
            controller: _nameController,
          ),

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

          // Confirm Password Field
          CustomTextFormField(
            label: AppString.confirmPasswordLabel,
            hintText: AppString.confirmPasswordHint,
            controller: _confirmPasswordController,
            obscureText: true,
            hasPasswordToggle: true,
          ),
        ],
      ),
    );
  }

  /// Handle SignUp
  void _handleSignUp() {
    if (!_formKey.currentState!.validate()) return;

    _authController.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );
  }

  void _disposeControllers() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}

/*

      Scaffold(
      appBar: const CustomAppBar(title: AppString.signUp),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const AuthHeader(title: AppString.signUp,),
            SizedBox(height: 20.h),

          ],
        ),
      ),
    );

 */

/*
_emailController.text.trim()
Prevents errors from extra spaces in input.
 */
