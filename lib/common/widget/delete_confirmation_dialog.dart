import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/card_list_controller.dart';

class DelectConfirmationDialog extends StatelessWidget {
  const DelectConfirmationDialog({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: const Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.red),
          SizedBox(width: 10),
          Text('Delete Item'),
        ],
      ),
      content: const Text(
        'Are you sure you want to permanently delete this item? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.back();

            final controller = Get.find<CardListController>();

            await controller.deleteCard(uid: uid);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 0,
          ),
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
