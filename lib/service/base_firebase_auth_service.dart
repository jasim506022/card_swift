import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

abstract class BaseFirebaseAuthService {
  // Get Current Class
  User? currentUser();

  /// Sign in and return UID
  Future<String> signIn({required String email, required String password});

  /// Create user with email & password
  Future<User?> signUp({required String email, required String password});

  // Understand All Parameter
  /// Save new user profile to Firestore
  Future<void> saveUserProfile({
    required UserModel userModel,
    required String uid,
  });

  /// Google Sign In
  Future<User?> signInGoogle();

  Future<void> signOut();

  Future<void> sendPasswordResetEmail({required String email});
}
