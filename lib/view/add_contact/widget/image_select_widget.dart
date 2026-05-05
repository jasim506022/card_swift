import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/style/app_assets.dart';
import '../../../controller/upload_controller.dart';
import '../../../model/contact_model.dart';

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({super.key, required this.contactModel});

  final ContactModel contactModel;

  @override
  Widget build(BuildContext context) {
    final UploadController uploadController = Get.find<UploadController>();
    return InkWell(
      onTap: () {
        uploadController.pickImage(ImageSource.gallery);
      },
      child: Row(
        children: [
          Obx(
            () {
              // 1. Jodi notun kono chobi select kora hoy (File)
              if (uploadController.selectedPhoto.value != null) {
                return CircleAvatar(
                  radius: 37.r, // Slightly larger than the inner one
                  backgroundColor: Colors.blue, // This acts as the border color
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: FileImage(
                      uploadController.selectedPhoto.value!,
                    ),
                  ),
                );
              }
              // 2. Jodi model a purono image URL thake
              else if (contactModel.image != null) {
                return CircleAvatar(
                  radius: 37.r, // Slightly larger than the inner one
                  backgroundColor: Colors.blue, // This acts as the border color
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: NetworkImage(contactModel.image!),
                  ),
                );
              }
              // 3. Jodi uporer konotai na thake (Default Asset)
              else {
                return CircleAvatar(
                  radius: 37.r, // Slightly larger than the inner one
                  backgroundColor: Colors.blue, // This acts as the border color
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: AssetImage(AppAssets.appIcon),
                  ),
                );
              }
            },

            /*
            () => CircleAvatar(
              radius: 35.r,
              backgroundImage:
                  uploadController.selectPhoto.value != null
                  ? FileImage(uploadController.selectPhoto.value!)
                  : AssetImage(AppAssets.appIcon) as ImageProvider,
            ),


             */
          ),
          SizedBox(width: 20.w),
          Text("ADD PICTURE"),
        ],
      ),
    );
  }
}
