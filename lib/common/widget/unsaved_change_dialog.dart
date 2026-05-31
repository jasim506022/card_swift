import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_string.dart';

class UnsavedChangesDialog extends StatelessWidget {

  final VoidCallback onDiscard;

  const UnsavedChangesDialog({
    super.key,

    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: const Text("Unsaved Changes"),
      content: const Text(
        "You have unsaved changes. Do you want to save them before leaving?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            onDiscard();
          },
          child: const Text("Discard", style: TextStyle(color: Colors.red)),
        ),

        // --- Save Button ---
        ElevatedButton(
          onPressed: () {
            Get.back();

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            AppString.saveBtn,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
