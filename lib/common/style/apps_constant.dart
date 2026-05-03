import 'package:shared_preferences/shared_preferences.dart';

class AppsConstant {
  /// SharedPreferences instance (  initialized in main)
  static SharedPreferences? sharedPreferences;

  /// Whether the onboarding screen has been viewed.
  static bool isViewed = false;

  static const String cloudName = "dhugcawup";
  static const String uploadTest = "upload-test";
  static const String uploadPreset = "upload_preset";
  static const String secureUrl = "secure_url";
  static const String cloudinaryBaseUrl =
      "https://api.cloudinary.com/v1_1/$cloudName/auto/upload";

  static final Map<String, String> modelKeyMap = const {
    "First Name": "firstName",
    "Last Name": "lastName",
    "Job Title": "jobTitle",
    "Company Name": "companyName",
    "Description": "description",
    "Street Name": "street",
    "City": "city",
    "Email Address": "email",
    "ZIP Code": "zipCode",
    "Country": "country",
    "Whatsapp": "whatsapp",
    "Website": "website",
    "Facebook": "facebook",
  };
}
