import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_function.dart';
import '../../common/style/app_string.dart';
import '../../common/style/app_validator.dart';
import '../../common/widget/app_clickable_text.dart';
import '../../controller/auth_controller.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../common/widget/app_button.dart';
import 'widget/auth_layout.dart';

/// Sign Up Page with Name, Email, Password, Confirm Password, and navigation to Sign In
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_handleIfLoading()) return;
        Get.back();
      },
      child: AuthLayout(
        onBackPressed: () {
          if (_handleIfLoading()) return;
          Get.back();
        },
        title: AppString.signUp,
        children: [
          _buildForm(),
          SizedBox(height: 20.h),
          // Sign Up Button with optional loading state
          AppButton(
            isLoading: _authController.isLoading,
            width: 1.sw,
            title: AppString.signUp,
            onTap: _handleSignUp,
          ),
          SizedBox(height: 20.h),

          /// Navigate to Sign In
          Center(
            child: AppClickableText(
              onTap: () {
                if (_handleIfLoading()) return;
                Get.back();
              },
              prefixText: AppString.alreadyHaveAccount,
              linkText: AppString.signIn,
            ),
          ),
        ],
      ),
    );
  }

  /// Form UI
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
            validator: AppValidator.validateName,
          ),

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
            validator: AppValidator.validatePassword,
          ),

          // Confirm Password Field
          CustomTextFormField(
            label: AppString.confirmPasswordLabel,
            hintText: AppString.confirmPasswordHint,
            controller: _confirmPasswordController,
            obscureText: true,
            hasPasswordToggle: true,
            validator: (String? value) => AppValidator.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
          ),
        ],
      ),
    );
  }

  /// Handle SignUp
  void _handleSignUp() {
    FocusScope.of(context).unfocus(); // dismiss keyboard
    if (!_formKey.currentState!.validate()) return;
    _authController.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
    );
  }

  bool _handleIfLoading() {
    if (_authController.isLoading.value) {
      AppFunction.flutterToast(msg: AppString.processingCannotBack);
      return true; // handled (blocked)
    }
    return false; // not loading
  }
}
