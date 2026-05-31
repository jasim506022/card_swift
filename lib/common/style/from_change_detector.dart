import 'package:card_swift/model/contact_model.dart';
import 'package:flutter/cupertino.dart';

import '../../controller/contact_form_controller.dart';
import '../../model/profile_model.dart';
import 'app_string.dart';

class FormChangeDetector {
  const FormChangeDetector._();

  static bool hasProfileChanges({
    required ProfileModel profile,
    required Map<String, TextEditingController> controllers,
    required ContactFormController formController,
    required bool photoChanged,
  }) {
    if (photoChanged) return true;

    final originalFields = <String, String>{
      AppString.hintFirstName: profile.firstName ?? '',
      AppString.hintLastName: profile.lastName ?? '',
      AppString.hintJobTitle: profile.jobTitle ?? '',
      AppString.hintCompanyName: profile.companyName ?? '',
      AppString.hintDescription: profile.description ?? '',
      AppString.hintStreetName: profile.street ?? '',
      AppString.hintCity: profile.city ?? '',
      AppString.hintZipCode: profile.zipCode ?? '',
      AppString.hintCountry: profile.country ?? '',
      AppString.hintWhatsapp: profile.whatsapp ?? '',
      AppString.hintWebsite: profile.website ?? '',
      AppString.hintFacebook: profile.facebook ?? '',
    };

    if (_hasFieldChanges(
      controllers: controllers,
      originalValues: originalFields,
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.mobileControllers,
      originalValues: profile.mobileNumbers ?? [],
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.phoneControllers,
      originalValues: profile.phoneNumber ?? [],
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.emailControllers,
      originalValues: profile.email ?? [],
    )) {
      return true;
    }

    return false;
  }

  static bool hasCardChanges({
    required ContactModel contactModel,
    required Map<String, TextEditingController> controllers,
    required ContactFormController formController,
    required bool photoChanged,
  }) {
    if (photoChanged) return true;

    final originalFields = <String, String>{
      AppString.hintFirstName: contactModel.firstName ?? '',
      AppString.hintLastName: contactModel.lastName ?? '',
      AppString.hintJobTitle: contactModel.jobTitle ?? '',
      AppString.hintCompanyName: contactModel.companyName ?? '',
      AppString.hintDescription: contactModel.description ?? '',
      AppString.hintStreetName: contactModel.street ?? '',
      AppString.hintCity: contactModel.city ?? '',
      AppString.hintZipCode: contactModel.zipCode ?? '',
      AppString.hintCountry: contactModel.country ?? '',
      AppString.hintWhatsapp: contactModel.whatsapp ?? '',
      AppString.hintWebsite: contactModel.website ?? '',
      AppString.hintFacebook: contactModel.facebook ?? '',
    };

    if (_hasFieldChanges(
      controllers: controllers,
      originalValues: originalFields,
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.mobileControllers,
      originalValues: contactModel.mobileNumbers ?? [],
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.phoneControllers,
      originalValues: contactModel.phoneNumber ?? [],
    )) {
      return true;
    }

    if (_hasListChanges(
      controllers: formController.emailControllers,
      originalValues: contactModel.email ?? [],
    )) {
      return true;
    }

    return false;
  }

  static bool _hasFieldChanges({
    required Map<String, TextEditingController> controllers,
    required Map<String, String> originalValues,
  }) {
    for (final entry in originalValues.entries) {
      final currentValue = controllers[entry.key]?.text ?? '';

      if (currentValue.trim() != entry.value.trim()) {
        return true;
      }
    }

    return false;
  }

  static bool _hasListChanges({
    required List<TextEditingController> controllers,
    required List<String> originalValues,
  }) {
    final currentValues = controllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (currentValues.length != originalValues.length) {
      return true;
    }

    for (final value in currentValues) {
      if (!originalValues.contains(value)) {
        return true;
      }
    }

    return false;
  }
}
