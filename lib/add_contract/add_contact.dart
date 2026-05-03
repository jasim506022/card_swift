import 'package:card_swift/controller/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/contact_model.dart';
import 'example/contact_field_builder.dart';
import 'example/contact_form_controller.dart';
import 'field_config.dart';
import 'image_select_widget.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key, required this.contactModel});

  final ContactModel contactModel;

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
      formController.initData(widget.contactModel);
    });
  }

  late final Map<String, TextEditingController> controllers;

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      uploadController.saveData(controllers, formController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
        actions: [TextButton(onPressed: _onSave, child: const Text("Save"))],
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
    );
  }

  /// ================= FIELD BUILDER =================

  /*
  Widget _buildField(FieldConfig field) {
    switch (field.fieldType) {
      case FieldType.mobile:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.mobileControllers,
          onAdd: formController.addMobile,
          onRemove: formController.removeMobile,
          keyboard: TextInputType.phone,
        );

      case FieldType.phone:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.phoneControllers,
          onAdd: formController.addPhone,
          onRemove: formController.removePhone,
          keyboard: TextInputType.phone,
        );

      case FieldType.email:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.emailControllers,
          onAdd: formController.addEmail,
          onRemove: formController.removeEmail,
          keyboard: TextInputType.emailAddress,
        );

      default:
        return CustomTextFormField(
          hintText: field.hint,
          controller: controllers[field.hint]!,
          textInputType: field.inputType,
          maxLines: field.inputType == TextInputType.multiline ? 3 : 1,
          validator: (value) => AppValidator.fieldValidator(field, value),
        );
    }
  }


  */

  /// ================= DYNAMIC FIELD UI =================

  /*
  Widget _dynamicField({
    required String title,
    required List<TextEditingController> controllers,
    required VoidCallback onAdd,
    required Function(int) onRemove,
    required TextInputType keyboard,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length,
          itemBuilder: (context, i) {
            return Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "$title ${i + 1}",
                    controller: controllers[i],
                    textInputType: keyboard,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => onRemove(i),
                ),
              ],
            );
          },
        ),
      ],
    );
  }


   */
}

/*
class DynamicFieldWidget extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final Function(int) onRemove;
  final TextInputType keyboard;

  const DynamicFieldWidget({
    super.key,
    required this.title,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
    required this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Title + Add Button
        Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),

        /// 🔹 Dynamic List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length,
          itemBuilder: (context, i) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers[i],
                    keyboardType: keyboard,
                    decoration: InputDecoration(
                      hintText: "$title ${i + 1}",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => onRemove(i),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}


 */

/*
  String modelKeyMap(String hint) {
    switch (hint) {
      case "First Name":
        return "firstName";
      case "Last Name":
        return "lastName";
      case "Job Title":
        return "jobTitle";
      case "Company Name":
        return "companyName";
      case "Description":
        return "description";
      case "Mobile Number":
        return "mobileNumbers"; // এখানে আপনি mobileNumbers দিয়েছেন
      case "Phone Number":
        return "phoneNumber";
      case "Email Address":
        return "email";
      case "Street Name":
        return "street";
      case "City":
        return "city";
      case "ZIP Code":
        return "zipCode";
      case "Country":
        return "country";
      case "Whatsapp":
        return "whatsapp";
      case "Website":
        return "website";
      case "Facebook":
        return "facebook";
      default:
        return "";
    }
  }


 */

/*

/*
  void _fillControllers(ContactModel contact) {
    final map = contact.toMap();

    for (var field in FieldConfig.fields) {
      final key = modelKeyMap[field.hint];

      if (key == null) continue;

      final value = map[key];

      /// =========================
      /// 🔥 LIST TYPE (Email / Mobile / Phone)
      /// =========================
      if (value is List) {
        for (var item in value) {
          if (item == null || item.toString().trim().isEmpty) continue;

          _addToList(field.fieldType, item.toString());
        }
      }
      /// =========================
      /// 🔥 STRING TYPE (Website, Name, etc.)
      /// =========================
      else if (value != null) {
        controllers[field.hint]?.text = value.toString();
      }
    }
  }


 */
  void _addToList(FieldType type, String value) {
    switch (type) {
      case FieldType.email:
        formController.emailControllers.add(TextEditingController(text: value));
        break;

      case FieldType.mobile:
        formController.mobileControllers.add(
          TextEditingController(text: value),
        );
        break;

      case FieldType.phone:
        formController.phoneControllers.add(TextEditingController(text: value));
        break;

      default:
        break;
    }
  }


 */
