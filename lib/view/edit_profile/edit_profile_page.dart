import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/from_change_detector.dart';
import '../../common/widget/unsaved_change_dialog.dart';
import '../../controller/contact_form_controller.dart';
import '../../controller/upload_controller.dart';
import '../../model/field_config.dart';
import '../add_contact/widget/contact_field_builder.dart';
import '../add_contact/widget/image_select_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final ContactFormController formController = Get.put(ContactFormController());

  final UploadController uploadController = Get.put(UploadController());

  late final Map<String, TextEditingController> controllers;

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
    return FormChangeDetector.hasProfileChanges(
      profile: widget.profileModel,
      controllers: controllers,
      formController: formController,
      photoChanged: uploadController.selectedPhoto.value != null,
    );
  }

  void _showBackConfirmationDialog() {
    Get.dialog(
      UnsavedChangesDialog(

        onDiscard: () {
          // Clear active pending image selection paths
          uploadController.selectedPhoto.value = null;

          // Safely navigate out of the edit profile page
          Get.back();
        },
      ),
      barrierDismissible: true,
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
            title: Text(AppString.updateProfileTitle),
            actions: [
              TextButton(onPressed: _onSave, child: Text(AppString.saveBtn)),
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
