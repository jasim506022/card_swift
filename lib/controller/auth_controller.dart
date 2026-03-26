import 'package:card_swift/common/style/app_assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../common/style/app_function.dart';
import '../common/style/app_string.dart';
import '../common/widget/app_alert_dialog.dart';
import '../common/widget/app_exception.dart';
import '../common/widget/error_dialog.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../route/route_name.dart';

/// Controller for authentication logic
/// Handles Email/Password, Google Sign-In, Password Reset, and Sign-Out
class AuthController extends GetxController {
  final AuthRepository _repository;

  /// Reactive loading state
  final RxBool isLoading = false.obs;

  AuthController({required AuthRepository authRepository})
    : _repository = authRepository;

  /// Sign up using email and password, then save user profile
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;

      final User? user = await _repository.signUp(
        email: email,
        password: password,
      );

      if (user != null) {
        var userModel = UserModel(
          name: name,
          email: email,
          uid: user.uid,
          createdAt: Timestamp.now(),
        );
        await _repository.saveProfile(user: userModel, uid: user.uid);
        _navigateToMainPage(AppString.signUpSuccessfulToast);
      }
    } catch (e) {
      // Handle any errors during registration
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      await _repository.signIn(email: email, password: password);
      _navigateToMainPage(AppString.signInSuccessfully);
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInGoogle() async {
    try {
      _showLoadingDialog();
      final user = await _repository.signInGoogle();
      Get.back();
      if (user != null) {
        if (await _repository.isUserProfileExists()) {
          _navigateToMainPage(AppString.signInSuccessfully);
        } else {
          var userModel = UserModel(
            name: user.displayName,
            email: user.email,
            uid: user.uid,
            createdAt: Timestamp.now(),
          );
          await _repository.saveProfile(user: userModel, uid: user.uid);
          _navigateToMainPage(AppString.signInSuccessfully);
        }
      }
    } catch (e) {
      Get.back();
      _handleError(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      isLoading.value = true;
      await _repository.sendPasswordReset(email: email);
      AppFunction.flutterToast(msg: AppString.sendingMailToast);
      Get.toNamed(RouteName.signPage);
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
      Get.offAllNamed(RouteName.signPage); // Redirect to login or splash
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> confirmExitApp() async {
    if (isLoading.value) {
      AppFunction.flutterToast(msg: AppString.loginProcessOngoingToast);
      return;
    }
    // Show a confirmation dialog and wait for the user's response.
    final bool shouldPop =
        await Get.dialog<bool>(
          AppAlertDialog(
            icon: Icons.question_mark_rounded,
            title: AppString.exitDialogTitle,
            content: AppString.confirmExitMessage,
            onConfirmPressed: () => Get.back(result: true),
            onCancelPressed: () => Get.back(result: false),
          ),
        ) ??
        false; // Default to `false` if the dialog is dismissed.
    // Close the app if the user confirms.
    if (shouldPop) SystemNavigator.pop();
  }



  /// Navigates to the main page with a success message.
  void _navigateToMainPage(String message) {
    AppFunction.flutterToast(msg: message);
    Get.offNamed(RouteName.homePage);
  }

  /// Displays a loading dialog.
  void _showLoadingDialog() {
    Get.dialog(
      ErrorDialogWidget(
        icon: AppAssets.warningIconPath,
        title: AppString.authPageDescription,
        buttonText: AppString.okayBtn,
      ),
      barrierDismissible: false,
    );
  }

  /// Handles exceptions by showing an error dialog.
  /// Shows a generic error for unknown exceptions.
  void _handleError(Object error) {
    if (error is AppException) {
      Get.dialog(
        ErrorDialogWidget(
          icon: AppAssets.warningIconPath,
          title: error.title!,
          content: error.message,
          buttonText: AppString.okayBtn,
        ),
      );
    } else {
      AppFunction.flutterToast(msg: "Something went wrong. Please try again.");
      debugPrint("Unexpected error: $error");
    }
  }
}
