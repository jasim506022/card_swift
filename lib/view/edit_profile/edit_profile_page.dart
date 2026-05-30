import 'package:card_swift/model/profile_model.dart';
import 'package:card_swift/view/add_contact/widget/image_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_string.dart';
import '../../controller/contact_form_controller.dart';
import '../../controller/upload_controller.dart';
import '../../model/field_config.dart';
import '../add_contact/widget/contact_field_builder.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final ContactFormController formController = Get.put(ContactFormController());

  final UploadController uploadController = Get.find<UploadController>();

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var field in FieldConfig.fields) field.hint: TextEditingController(),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formController.initDataProfile(widget.profileModel, controllers);
    });
  }

  late final Map<String, TextEditingController> controllers;

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      uploadController.saveProfile(
        controllers,
        formController,
        widget.profileModel.image ?? "",
      );
    }
  }

  bool _hasUnsavedChanges() {
    // 1. Check if a new photo has been selected
    if (uploadController.selectedPhoto.value != null) return true;

    final profile = widget.profileModel;

    // 2. Cross-reference evaluation mapping for explicit profile single fields
    final Map<String, String> originalFieldMapping = {
      AppString.hintFirstName: profile.firstName ?? "",
      AppString.hintLastName: profile.lastName ?? "",
      AppString.hintJobTitle: profile.jobTitle ?? "",
      AppString.hintCompanyName: profile.companyName ?? "",
      AppString.hintDescription: profile.description ?? "",
      AppString.hintStreetName: profile.street ?? "",
      AppString.hintCity: profile.city ?? "",
      AppString.hintZipCode: profile.zipCode ?? "",
      AppString.hintCountry: profile.country ?? "",
      AppString.hintWhatsapp: profile.whatsapp ?? "",
      AppString.hintWebsite: profile.website ?? "",
      AppString.hintFacebook: profile.facebook ?? "",
    };

    for (var entry in originalFieldMapping.entries) {
      final textInput = controllers[entry.key]?.text ?? "";
      if (textInput != entry.value) {
        return true;
      }
    }

    // 3. Optional deep check: Check lists arrays managed inside ContactFormController
    final currentMobiles = formController.mobileControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final originalMobiles = profile.mobileNumbers ?? [];
    if (currentMobiles.length != originalMobiles.length ||
        currentMobiles.any((e) => !originalMobiles.contains(e))) {
      return true;
    }

    final currentPhones = formController.phoneControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final originalPhones = profile.phoneNumber ?? [];
    if (currentPhones.length != originalPhones.length ||
        currentPhones.any((e) => !originalPhones.contains(e))) {
      return true;
    }

    final currentEmails = formController.emailControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final originalEmails = profile.email ?? [];
    if (currentEmails.length != originalEmails.length ||
        currentEmails.any((e) => !originalEmails.contains(e))) {
      return true;
    }

    return false;
  }

  /// 💬 Pop Confirmation Alert Window Dialog
  void _showBackConfirmationDialog() {
    Get.defaultDialog(
      title: "Unsaved Changes",
      middleText:
          "You have unsaved changes. Do you want to save them before leaving?",
      textConfirm: "Save",
      textCancel: "Discard",
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      onConfirm: () {
        Get.back(); // Dismiss confirmation dialog window box overlay
      },
      onCancel: () {
        uploadController.selectedPhoto.value =
            null; // Clean active pending asset state path tracks
        Get.back(); // Dismiss confirmation dialog window box overlay
        Get.back(); // Force structural context pop out safety routine
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool savingState = uploadController.isSaving.value;

      return PopScope(
        // 🔥 FIX: We set canPop to false to always intercept the gesture manually
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          if (savingState) {
            debugPrint("Back action blocked. Currently saving to Firebase...");
            return;
          }

          // Check for edits explicitly on gesture execution frame
          if (_hasUnsavedChanges()) {
            Future.microtask(() => _showBackConfirmationDialog());
          } else {
            // 🔥 FIX: If no edits were made, pop out of the page immediately
            Get.back();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Update Profile"),
            actions: [
              TextButton(onPressed: _onSave, child: const Text("Save")),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageSelect(profileModel: widget.profileModel),
                    SizedBox(height: 15.h),

                    /// ================= FIELDS =================
                    ...FieldConfig.fields.map((field) {
                      return ContactFieldBuilder(
                        field: field,
                        controllers: controllers,
                        formController: formController,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
