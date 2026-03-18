import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import '../service/firebase_auth_service.dart';

class AuthRepository {
  // final FirebaseAuthService _dataFirebaseAuthService = FirebaseAuthService();

  // Why not user _dataFirebase

  final FirebaseAuthService _service = FirebaseAuthService();

  // Why don't use await
  Future<User?> signUp(String email, String password) {
    return _service.signUp(email: email, password: password);
  }

  Future<void> saveProfile({required UserModel user, required String uid}) {
    return _service.saveUserProfile(userModel: user, uid: uid);
  }

  /// Sign in and return UID
  Future<String> signIn({required String email, required String password}) {
    return _service.signIn(email: email, password: password);
  }

  Future<User?> signInGoogle() {
    return _service.signInGoogle();
  }

  Future<void> sendPasswordReset({required String email}) {
    return _service.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() {
    return _service.signOut();
  }
}

/*
Either<Failure, User>
Result<User>
 */
