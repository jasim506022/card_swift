import 'package:card_swift/common/style/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_function.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (_handleIfLoading()) return;
          Get.back();
        },
        child: AuthLayout(
          title: AppString.forgetPassword,
          children: [
            _buildForm(),
            SizedBox(height: 15.h),
            // Send Reset Email Button
            AppButton(
              title: AppString.sendResetEmailBtn,
              width: 1.sw,
              isLoading: _authController.isLoading,
              onTap: _handleResetPassword,
            ),
            SizedBox(height: 20.h),
            Center(
              child: AppClickableText(
                prefixText: AppString.backTo,
                linkText: AppString.signIn,
                onTap: () {
                  if (_handleIfLoading()) return;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
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
        validator: AppValidator.validateEmail,
      ),
    );
  }

  /// Handle sending reset password email
  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      _authController.resetPassword(email: _emailController.text.trim());
    }
  }

  bool _handleIfLoading() {
    if (_authController.isLoading.value) {
      AppFunction.flutterToast(msg: AppString.processingCannotBack);
      return true; // handled (blocked)
    }
    return false; // not loading
  }
}
