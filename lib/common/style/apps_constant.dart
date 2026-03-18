import 'package:shared_preferences/shared_preferences.dart';

class AppsConstant {
  /// SharedPreferences instance (  initialized in main)
  static SharedPreferences? sharedPreferences;

  /// Whether the onboarding screen has been viewed.
  static bool isViewed = false;
}
