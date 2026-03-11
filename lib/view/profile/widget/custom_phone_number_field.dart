
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/app_string.dart';
import '../../custom_text_form_field.dart';
import '../profile_view.dart';

class CustomPhoneNumberField extends StatelessWidget {
  const CustomPhoneNumberField({
    super.key,
    required this.number,
    required this.phoneController,
  });

  final PhoneNumber number;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {},
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 10,
      ),
      initialValue: number,
      textFieldController: phoneController,
      formatInput: false,
      inputDecoration: CustomTextFieldDecoration.inputDecoration(
        hintText: AppString.enterPhone,
      ),
    );
  }
}

