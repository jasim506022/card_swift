import 'package:card_swift/view/edit_profile/widget/image_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/upload_controller.dart';
import '../../model/contact_model.dart';
import 'widget/contact_field_builder.dart';
import '../../controller/contact_form_controller.dart';
import '../../model/field_config.dart';
import 'widget/image_select_widget.dart';

class AddContact extends StatefulWidget {
  const AddContact({
    super.key,
    required this.contactModel,
    this.isProfileUpdate = false,
  });

  final ContactModel contactModel;
  final bool isProfileUpdate;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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
      formController.initData(widget.contactModel, controllers);
    });
  }

  late final Map<String, TextEditingController> controllers;

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      uploadController.saveContact(
        controllers,
        formController,
        widget.contactModel.image ?? "",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool savingState = uploadController.isSaving.value;

      return PopScope(
        canPop: !savingState,
        // সেভিং ট্রু হলে ফিজিক্যাল বা জেসচার ব্যাক বাটন লক থাকবে
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && savingState) {
            debugPrint("Back action blocked. Currently saving to Firebase...");
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Contact"),
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
                    ImageSelectWidget(contactModel: widget.contactModel),

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
