import 'package:flutter/material.dart';

import '../common/style/app_string.dart';

enum FieldType {
  firstName,
  lastName,
  jobTitle,
  companyName,
  description,
  mobile,
  streetName,
  email,
  phone,
  city,
  website,
  zipCode,
  country,
  facebook,
  whatsapp,
}

class FieldConfig {
  final String hint;
  final TextInputType inputType;
  final bool isRequired;
  final FieldType fieldType;

  const FieldConfig({
    required this.fieldType,
    required this.hint,
    required this.inputType,
    this.isRequired = false,
  });

  static final List<FieldConfig> fields = [
    const FieldConfig(
      hint: AppString.hintFirstName,
      inputType: TextInputType.name,
      fieldType: FieldType.firstName,
      isRequired: true,
    ), // Index 0
    const FieldConfig(
      hint: AppString.hintLastName,
      inputType: TextInputType.name,
      fieldType: FieldType.lastName,
    ), // Index 1
    const FieldConfig(
      hint: AppString.hintJobTitle,
      inputType: TextInputType.text,
      isRequired: true,
      fieldType: FieldType.jobTitle,
    ), // Index 2
    const FieldConfig(
      hint: AppString.hintCompanyName,
      inputType: TextInputType.text,
      isRequired: true,
      fieldType: FieldType.companyName,
    ),
    const FieldConfig(
      hint: AppString.hintDescription,
      inputType: TextInputType.multiline,
      fieldType: FieldType.description,
    ),
    const FieldConfig(
      hint: AppString.hintMobileNumber,
      inputType: TextInputType.phone,
      isRequired: true,
      fieldType: FieldType.mobile,
    ),
    const FieldConfig(
      hint: AppString.hintPhoneNumber,
      inputType: TextInputType.phone,
      fieldType: FieldType.phone,
    ),
    const FieldConfig(
      hint: AppString.hintEmailAddress,
      inputType: TextInputType.emailAddress,
      fieldType: FieldType.email,
      isRequired: true,
    ),
    const FieldConfig(
      hint: AppString.hintStreetName,
      inputType: TextInputType.streetAddress,
      isRequired: true,
      fieldType: FieldType.streetName,
    ),
    const FieldConfig(
      hint: AppString.hintCity,
      inputType: TextInputType.text,
      isRequired: true,
      fieldType: FieldType.city,
    ),
    const FieldConfig(
      hint: AppString.hintZipCode,
      inputType: TextInputType.number,
      fieldType: FieldType.zipCode,
    ),
    const FieldConfig(
      hint: AppString.hintCountry,
      inputType: TextInputType.text,
      fieldType: FieldType.country,
    ),
    const FieldConfig(
      hint: AppString.hintWhatsapp,
      inputType: TextInputType.phone,
      fieldType: FieldType.whatsapp,
    ),
    const FieldConfig(
      hint: AppString.hintWebsite,
      inputType: TextInputType.url,
      fieldType: FieldType.website,
    ),
    const FieldConfig(
      hint: AppString.hintFacebook,
      inputType: TextInputType.url,
      fieldType: FieldType.facebook,
    ),
  ];
}
