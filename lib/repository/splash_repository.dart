import 'package:firebase_auth/firebase_auth.dart';
import '../service/base_firebase_auth_service.dart';
import '../service/firebase_auth_service.dart';

class SplashRepository {
  final FirebaseAuthService _authService;

  SplashRepository({required FirebaseAuthService authService})
    : _authService = authService;

  User? currentUser() => _authService.currentUser();
}

/*
Repository (Decoupled + Injectable)
 final FirebaseAuthService _dataFirebaseAuthService = FirebaseAuthService();

 👉 Problem:
Tight coupling ❌
Hard to test ❌
Violates dependency inversion ❌

✅ After:
Uses abstraction (BaseFirebaseAuthService)
Injected from outside
✔ Clean
✔ Replaceable
✔ Testable
 */

/*
A value of type 'User? Function()' can't be returned from the method 'currentUser' because it has a return type of 'User?'. (Documentation)
Missing Pareantess
 */
