import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/style/app_assets.dart';
import '../../../controller/upload_controller.dart';

class ImageSelect extends StatelessWidget {
  const ImageSelect({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    final UploadController uploadController = Get.find<UploadController>();

    return InkWell(
      onTap: () {
        // Show the option selector instead of directly opening gallery
        _showImageSourceDialog(uploadController);
      },
      child: Row(
        children: [
          Obx(() {
            if (uploadController.selectedPhoto.value != null) {
              return CircleAvatar(
                radius: 37.r,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundImage: FileImage(
                    uploadController.selectedPhoto.value!,
                  ),
                ),
              );
            } else if (profileModel.image != null) {
              return CircleAvatar(
                radius: 37.r,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundImage: NetworkImage(profileModel.image!),
                ),
              );
            } else {
              return CircleAvatar(
                radius: 37.r,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundImage: AssetImage(AppAssets.appIcon),
                ),
              );
            }
          }),
          SizedBox(width: 20.w),
          Text("ADD PICTURE", style: AppTextStyle.button.copyWith(color: AppColors.black)),
        ],
      ),
    );
  }

  // --- Bottom Sheet Options ---
  void _showImageSourceDialog(UploadController uploadController) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Image Source",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Camera"),
              onTap: () {
                Get.back(); // Close bottom sheet
                uploadController.pickImage(ImageSource.camera);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text("Gallery"),
              onTap: () {
                Get.back(); // Close bottom sheet
                uploadController.pickImage(ImageSource.gallery);
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
