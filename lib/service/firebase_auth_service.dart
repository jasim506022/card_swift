import 'package:card_swift/service/base_firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

/// Base contract for Firebase authentication services
class FirebaseAuthService extends BaseFirebaseAuthService {
  /*
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;


   */

  // Why is best here ; Why no up

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  User? currentUser() => _auth.currentUser;

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

  @override
  Future<void> saveUserProfile({
    required String uid,
    required UserModel userModel,
  }) async {
    await _firestore.collection('users').doc(uid).set(userModel.toMap());
  }

  /// Sign in user with email & password
  /// Returns UID on success or throws FirebaseAuthException
  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!.uid;
  }

  /// Sign out from all providers
  @override
  Future<void> signOut() async {
    // Sign out from Firebase
    await _auth.signOut();

    // Optional: Sign out from Google if previously signed in
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }

  /// Google Sign In
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

  /// Send password reset email
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}

/*
Named parameters make code more readable when calling.
Dependency Injection (Very Important)
 */

/*
Why

This allows dependency injection, which is important for:

unit testing

mocking Firebase

flexible architecture

Example test:

FirebaseAuthService(auth: mockAuth);

Senior Flutter developers always allow dependency injection.

 1. Professional Flutter projects use short private names.


 */

/*
❓ “Why define dependencies in constructor instead of top?”
❌ Bad (hard-coded)
final _firebaseAuth = FirebaseAuth.instance;
Good (your current improved version)
FirebaseAuth? auth
✔ Benefits:
Testable (mock Firebase easily)
Flexible (swap implementation)
Clean architecture (dependency injection)
Scalable for large apps
 */
