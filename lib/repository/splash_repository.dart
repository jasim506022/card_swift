import 'package:firebase_auth/firebase_auth.dart';
import '../service/firebase_auth_service.dart';

class SplashRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  User? currentUser() => _authService.currentUser();
}
