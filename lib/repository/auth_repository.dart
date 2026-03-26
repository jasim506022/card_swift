import 'package:firebase_auth/firebase_auth.dart';

import '../common/style/app_function.dart';
import '../model/user_model.dart';
import '../service/firebase_auth_service.dart';

/// Repository layer for authentication.
/// Provides a clean abstraction over [FirebaseAuthService].
/// Handles Email/Password, Google Sign-In, profile saving, password reset, and sign-out.
class AuthRepository {
  final FirebaseAuthService _service;

  /// Constructor with optional dependency injection for testing
  AuthRepository({FirebaseAuthService? service})
    : _service = service ?? FirebaseAuthService();

  /// Sign up with email and password
  /// Returns Firebase [User] on success
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _service.signUp(email: email, password: password);
    } catch (e) {
      AppFunction.handleException(e);
      rethrow;
    }
  }

  /// Save user profile to Firestore
  /// [user] - User data
  /// [uid] - Firebase user ID
  Future<void> saveProfile({
    required UserModel user,
    required String uid,
  }) async {
    try {
      await _service.saveUserProfile(userModel: user, userId: uid);
    } catch (e) {
      AppFunction.handleException(e);
      rethrow;
    }
  }

  /// Sign in with email and password
  /// Returns UID string on success
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _service.signIn(email: email, password: password);
    } catch (e) {
      AppFunction.handleException(e);
      rethrow;
    }
  }

  /// Sign in using Google
  /// Returns Firebase [User] on success or null if canceled
  Future<User?> signInGoogle() {
    return _service.signInGoogle();
  }

  /// Send password reset email
  Future<void> sendPasswordReset({required String email}) {
    return _service.sendPasswordResetEmail(email: email);
  }

  /// Sign out from all providers (Firebase & Google)
  Future<void> signOut() {
    return _service.signOut();
  }

  /// Checks if a user profile exists in Firestore.
  Future<bool> isUserProfileExists() async {
    try {
      return await _service.userExists();
    } catch (e) {
      AppFunction.handleException(e);
      rethrow;
    }
  }
}
