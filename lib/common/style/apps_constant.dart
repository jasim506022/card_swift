import 'package:shared_preferences/shared_preferences.dart';

class AppsConstant {
  /// SharedPreferences instance (  initialized in main)
  static SharedPreferences? sharedPreferences;

  /// Whether the onboarding screen has been viewed.
  static bool isViewed = false;
  static const String GEMINI_API_KEY =
      "AIzaSyCdaT-NClGJn8T1As9tDKprfJgGbw7ai0E";

  static const String cloudName = "dhugcawup";
  static const String defaultCardBackground =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdqpdEN5cM_sGSv0B0W5vFfCroA3d-x-mPZg&s";
  static const String uploadTest = "upload-test";
  static const String uploadPreset = "upload_preset";
  static const String secureUrl = "secure_url";
  static const String cloudinaryBaseUrl =
      "https://api.cloudinary.com/v1_1/$cloudName/auto/upload";

  static const String image =
      "https://img.freepik.com/premium-photo/corporate-portrait-proud-with-business-man-office-start-professional-career-as-intern-company-confident-suit-with-smile-formal-employee-workplace-administration_590464-381909.jpg?semt=ais_hybrid&w=740&q=80";

  static final Map<String, String> modelKeyMap = const {
    "First Name": "firstName",
    "Last Name": "lastName",
    "Job Title": "jobTitle",
    "Company Name": "companyName",
    "Description": "description",
    "Street Name": "street",
    "City": "city",
    "Mobile Number": "mobileNumbers",
    "Phone Number": "phoneNumber",
    "Email Address": "email",
    "ZIP Code": "zipCode",
    "Country": "country",
    "Whatsapp": "whatsapp",
    "Website": "website",
    "Facebook": "facebook",
  };

  static final Map<String, String> reviewModel = const {
    "First Name": "firstName",
    "Last Name": "lastName",
    "Job Title": "jobTitle",
    "Company Name": "companyName",
    "Description": "description",
    "Street Name": "street",
    "City": "city",
    "Mobile Number": "mobileNumbers",
    "Phone Number": "phones",
    "Email Address": "emails",
    "ZIP Code": "zipCode",
    "Country": "country",
    "Whatsapp": "whatsapp",
    "Website": "websites",
    "Facebook": "facebook",
  };
}
