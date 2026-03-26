import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

abstract class BaseFirebaseAuthService {
  /// Returns the currently signed-in Firebase [User], or null if none
  User? currentUser();

  /// Sign in a user using email & password
  /// Returns the user UID on success
  Future<String> signIn({required String email, required String password});

  /// Create a new user using email & password
  /// Returns the Firebase [User] on success
  Future<User?> signUp({required String email, required String password});

  /// Save new user profile to Firestore
  /// [userId] is the Firebase UID of the user
  Future<void> saveUserProfile({
    required UserModel userModel,
    required String userId,
  });

  /// Sign in with Google account
  /// Returns the Firebase [User] on success
  Future<User?> signInGoogle();

  /// Sign out the currently signed-in user
  Future<void> signOut();

  /// Send a password reset email to [email]
  Future<void> sendPasswordResetEmail({required String email});

  Future<bool> userExists();
}
