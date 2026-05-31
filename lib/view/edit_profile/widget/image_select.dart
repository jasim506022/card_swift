import 'dart:io';

import 'package:card_swift/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/style/app_assets.dart';
import '../../../controller/upload_controller.dart';

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({super.key, required this.contactModel});

  final ContactModel contactModel;

  @override
  Widget build(BuildContext context) {
    final UploadController uploadController = Get.find<UploadController>();

    return Obx(() {
      final file = uploadController.selectedPhoto.value;
      final networkImage = contactModel.image;

      return Container(
        width: 1.sw,
        height: 200.r,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: _getImage(file, networkImage),
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }

  ImageProvider _getImage(File? file, String? networkImage) {
    if (file != null) {
      return FileImage(file);
    }

    if (networkImage != null && networkImage.isNotEmpty) {
      return NetworkImage(networkImage);
    }

    return const AssetImage(AppAssets.appIcon);
  }
}
