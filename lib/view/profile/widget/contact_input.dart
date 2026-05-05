import 'package:card_swift/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'input_field_row.dart';

class ContactInput extends StatelessWidget {
  const ContactInput({super.key, required this.contactModel});

  final ContactModel contactModel;

  Widget _buildListSection({
    required List<String>? items,
    required IconData icon,
    required String emptyText,
  }) {
    if (items != null && items.isNotEmpty) {
      return Column(
        children: items.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: InputFieldRow(icon: icon, text: item),
          );
        }).toList(),
      );
    }

    return InputFieldRow(icon: icon, text: emptyText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 📧 Email
        _buildListSection(
          items: contactModel.email,
          icon: Icons.email_outlined,
          emptyText: "No email available",
        ),

        /// 📱 Mobile
        _buildListSection(
          items: contactModel.mobileNumbers,
          icon: Icons.phone,
          emptyText: "No mobile number available",
        ),
      ],
    );
  }
}
