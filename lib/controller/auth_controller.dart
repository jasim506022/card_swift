import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  // Understand This Code
  AuthRepository authRepository;

  AuthController({required this.authRepository});

  // Reactive loading variable
  final RxBool isLoading = false.obs;

  Future<void> signUp(String email, String password, String name) async {
    try {
      print("Bangladesh");
      isLoading.value = true;
      final user = await authRepository.signUp(email, password);

      if (user != null) {
        var userModel = UserModel(
          name: name,
          email: email,
          uid: user.uid,
          createdAt: Timestamp.now(),
        );
        await authRepository.saveProfile(user: userModel, uid: user.uid);
        Get.snackbar("Successfully ", "Sign Up");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      await authRepository.signIn(email: email, password: password);
      Get.snackbar("Successfully ", "Login");
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInGoogle() async {
    final user = await authRepository.signInGoogle();
    if (user != null) {
      var userModel = UserModel(
        name: user.displayName,
        email: user.email,
        uid: user.uid,
        createdAt: Timestamp.now(),
      );
      await authRepository.saveProfile(user: userModel, uid: user.uid);
      Get.snackbar("Successfully ", "Login");
    }
    ();
  }

  Future<void> resetPassword(String email) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      await authRepository.sendPasswordReset(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent to $email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      await authRepository.signOut();
      Get.offAllNamed('/login'); // Redirect to login or splash
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    } finally {
      isLoading.value = false;
    }
  }
}