import 'package:card_swift/view/edit_profile/widget/image_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/from_change_detector.dart';
import '../../common/widget/unsaved_change_dialog.dart';
import '../../controller/upload_controller.dart';
import '../../model/contact_model.dart';
import 'widget/contact_field_builder.dart';
import '../../controller/contact_form_controller.dart';
import '../../model/field_config.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();


  final ContactFormController formController = Get.put(ContactFormController());
  final UploadController uploadController = Get.put(UploadController());

  late final ContactModel contactModel;
  late final bool isEdit;
  late final Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    contactModel = args!['contactModel'] as ContactModel;
    isEdit = args['isEdit'];

    print(isEdit);

    controllers = {
      for (var field in FieldConfig.fields) field.hint: TextEditingController(),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formController.initData(contactModel, controllers);
    });
  }

  bool _hasUnsavedChanges() {
    return FormChangeDetector.hasCardChanges(
      contactModel: contactModel,
      controllers: controllers,
      formController: formController,
      photoChanged: uploadController.selectedPhoto.value != null,
    );
  }

  void _showBackConfirmationDialog() {
    Get.dialog(
      UnsavedChangesDialog(
        onDiscard: () {
          uploadController.selectedPhoto.value = null;

          Get.back();
        },
      ),
      barrierDismissible: true,
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      isEdit
          ? uploadController.updateCard(
              controllers,
              formController,
              contactModel.image ?? "",
              contactModel.uid!,
            )
          : uploadController.saveContact(
              controllers,
              formController,
              contactModel.image ?? "",
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool savingState = uploadController.isSaving.value;

      return PopScope(
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
            Get.back();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? "Update Contact" : "Add Contact"),
            actions: [
              TextButton(
                onPressed: _onSave,
                child: Text(isEdit ? "Update" : "Save"),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageSelectWidget(contactModel: contactModel),

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
