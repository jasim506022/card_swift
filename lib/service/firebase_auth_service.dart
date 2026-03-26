import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';
import 'base_firebase_auth_service.dart';

/// Firebase Authentication Service implementation
/// Handles Email/Password, Google Sign-In, and Firestore user profile
class FirebaseAuthService extends BaseFirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Returns the currently signed-in Firebase [User], or null if none
  @override
  User? currentUser() => _auth.currentUser;

  /// Sign up new user using Email & Password
  /// Returns the Firebase [User] object on success
  @override
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    var credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  /// Save user profile data to Firestore under `users/{userId}`
  @override
  Future<void> saveUserProfile({
    required String userId,
    required UserModel userModel,
  }) async {
    await _firestore.collection('users').doc(userId).set(userModel.toMap());
  }

  /// Sign in using Email & Password
  /// Returns the user UID on success
  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Safe to use ! because signInWithEmailAndPassword throws on failure
    return userCredential.user!.uid;
  }

  /// Sign out from Firebase and Google (if previously signed in)
  @override
  Future<void> signOut() async {
    // Sign out from Firebase
    await _auth.signOut();

    // Optional: Sign out from Google if previously signed in
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }

  /// Sign in using Google
  /// Returns the Firebase [User] object on success or null if canceled
  @override
  Future<User?> signInGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  /// Send password reset email to [email]
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// Check if the user exists in Firestore
  @override
  Future<bool> userExists() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final userDoc = await _firestore.collection('users').doc(userId).get();

    return userDoc.exists;
  }
}
