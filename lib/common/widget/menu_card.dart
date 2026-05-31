import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../model/contact_model.dart';
import '../../route/route_name.dart';
import 'delete_confirmation_dialog.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({super.key, required this.contact});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            Get.toNamed(
              RouteName.addCard,
              arguments: {'contactModel': contact, 'isEdit': true},
            );
            break;

          case 'delete':
            _showDeleteConfirmationDialog(contact.uid ?? '');
            break;
        }
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: FaIcon(FontAwesomeIcons.ellipsis, size: 20.h),
      ),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue, size: 20),
              SizedBox(width: 10),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _showDeleteConfirmationDialog(String uid) async {
  await Get.dialog(DelectConfirmationDialog(uid: uid));
}
