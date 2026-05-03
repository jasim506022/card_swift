import 'package:flutter/cupertino.dart';

import '../../add_contract/field_config.dart';
import 'app_string.dart';

class AppValidator {
  /// **Checks if a string is null or empty after trimming.**
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Predefined regex patterns for validation.**
  static final RegExp _emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp _namePattern = RegExp(r'^[a-zA-Z\s]+$');

  /// **Validates an email address.**
  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyEmail;
    if (!_emailPattern.hasMatch(trimmedValue!)) {
      return AppString.invalidEmailFormat;
    }
    return trimmedValue.length > 320 ? AppString.emailTooLong : null;
  }

  /// **Validates a password.**
  static String? validatePassword(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyPassword;
    if (trimmedValue!.length < 6) return AppString.passwordTooShort;
    if (!trimmedValue.contains(RegExp(r'[A-Z]'))) {
      return AppString.passwordUppercase;
    }
    if (!trimmedValue.contains(RegExp(r'[a-z]'))) {
      return AppString.passwordLowercase;
    }
    if (!trimmedValue.contains(RegExp(r'\d'))) return AppString.passwordNumber;
    return trimmedValue.length > 20 ? AppString.passwordTooLong : null;
  }

  /// **Validates confirm password.**
  static String? validateConfirmPassword(String? value, String password) {
    return _isEmpty(value)
        ? AppString.confirmPasswordRequired
        : (value!.trim() != password ? AppString.passwordMismatch : null);
  }

  /// **Validates a name (only letters & spaces).**
  static String? validateName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyName;
    if (trimmedValue!.length < 2) return AppString.nameTooShort;
    if (trimmedValue.length > 50) return AppString.nameTooLong;
    return _namePattern.hasMatch(trimmedValue) ? null : AppString.nameInvalid;
  }

  static String? fieldValidator(FieldConfig field, String? value) {
    final v = value?.trim();

    // ✅ Required check
    if (field.isRequired && (v == null || v.isEmpty)) {
      return "${field.hint} is required";
    }

    // ✅ Optional + empty → skip validation
    if (!field.isRequired && (v == null || v.isEmpty)) {
      return null;
    }

    // ✅ If value exists → validate
    switch (field.fieldType) {
      case FieldType.firstName:
      case FieldType.lastName:
        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(v!)) {
          return "Only letters allowed";
        }
        if (v.length < 2) {
          return "Too short";
        }
        break;

      case FieldType.jobTitle:
        if (v!.length < 2) {
          return "Job title too short";
        }
        break;

      case FieldType.companyName:
        if (v!.length < 2) {
          return "Company name too short";
        }
        break;

      case FieldType.mobile:
      case FieldType.phone:
      case FieldType.whatsapp:
        if (!RegExp(r'^\d{11}$').hasMatch(v!)) {
          return "Must be 11 digits";
        }
        break;

      case FieldType.email:
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!)) {
          return "Invalid email";
        }
        break;

      case FieldType.streetName:
        if (v!.length < 3) {
          return "Street too short";
        }
        break;

      case FieldType.city:
      case FieldType.country:
        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(v!)) {
          return "Only letters allowed";
        }
        break;

      case FieldType.zipCode:
        if (!RegExp(r'^\d{4,6}$').hasMatch(v!)) {
          return "Invalid ZIP";
        }
        break;

      case FieldType.website:
        if (!RegExp(r'https?:\/\/').hasMatch(v!)) {
          return "Invalid URL";
        }
        break;

      case FieldType.facebook:
        if (!v!.contains("facebook.com")) {
          return "Invalid Facebook link";
        }
        break;

      case FieldType.description:
        break;
    }

    return null;
  }

  /*
  static String? fieldValidator(FieldConfig field, String? value) {
    if (field.isRequired && (value == null || value.trim().isEmpty)) {
      return "${field.hint} is required";
    }

    final trimmedValue = value?.trim();
    switch (field.hint) {
      case hit:
        if (!AppValidator._isEmpty(trimmedValue)) {
          return AppValidator.validateName(trimmedValue);
        }
        break;
      case TextInputType.emailAddress:
        if (!AppValidator._isEmpty(trimmedValue)) {
          return AppValidator.validateEmail(trimmedValue);
        }
        break;
      case TextInputType.phone:
        if (!AppValidator._isEmpty(trimmedValue)) {
          final phonePattern = RegExp(r'^\d{7,15}$');
          if (!phonePattern.hasMatch(trimmedValue!)) {
            return "Invalid ${field.hint}";
          }
        }
        break;
      default:
        break; // For other types, no extra validation
    }

    return null; // Valid input
  }


   */
}
