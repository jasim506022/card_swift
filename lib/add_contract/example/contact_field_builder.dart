
import 'package:flutter/material.dart';

import '../../common/style/app_validator.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../dynamic_field_widget.dart';
import '../field_config.dart';
import 'contact_form_controller.dart';

class ContactFieldBuilder extends StatelessWidget {
  final FieldConfig field;
  final Map<String, TextEditingController> controllers;
  final ContactFormController formController;

  const ContactFieldBuilder({
    super.key,
    required this.field,
    required this.controllers,
    required this.formController,
  });

  @override
  Widget build(BuildContext context) {
    switch (field.fieldType) {

    /// 🔹 MOBILE
      case FieldType.mobile:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.mobileControllers,
          onAdd: formController.addMobile,
          onRemove: formController.removeMobile,
          keyboard: TextInputType.phone,
        );

    /// 🔹 PHONE
      case FieldType.phone:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.phoneControllers,
          onAdd: formController.addPhone,
          onRemove: formController.removePhone,
          keyboard: TextInputType.phone,
        );

    /// 🔹 EMAIL
      case FieldType.email:
        return DynamicFieldWidget(
          title: field.hint,
          controllers: formController.emailControllers,
          onAdd: formController.addEmail,
          onRemove: formController.removeEmail,
          keyboard: TextInputType.emailAddress,
        );

    /// 🔹 NORMAL FIELD
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
}

