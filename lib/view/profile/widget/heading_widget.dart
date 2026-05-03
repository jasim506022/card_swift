import 'dart:io';

import 'package:card_swift/add_contract/add_contact.dart';
import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/style/app_text_style.dart';

class HeadingWidget extends StatefulWidget {
  const HeadingWidget({super.key, required this.contactModel});

  final ContactModel contactModel;

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  File? fileImage;

  String image =
      "https://img.freepik.com/premium-photo/corporate-portrait-proud-with-business-man-office-start-professional-career-as-intern-company-confident-suit-with-smile-formal-employee-workplace-administration_590464-381909.jpg?semt=ais_hybrid&w=740&q=80";
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      height: .25.sh,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.authHeadBackground),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                editableTextRow(
                  title: widget.contactModel.firstName ?? AppString.profileName,
                ),
                Column(
                  children: [
                    editableTextRow(
                      title:
                          widget.contactModel.jobTitle ??
                          AppString.appDesignation,
                      textStyle: AppTextStyle.bodyTitle.copyWith(
                        color: AppColors.yellow,
                      ),
                    ),
                    editableTextRow(
                      title: AppString.companyName,
                      textStyle: AppTextStyle.mediumNormal,
                    ),
                  ],
                ),
              ],
            ),
          ),

          buildImage(),
        ],
      ),
    );
  }

  Row editableTextRow({required String title, TextStyle? textStyle}) {
    return Row(
      children: [
        Text(title, style: textStyle ?? AppTextStyle.subSmallTitle),
        SizedBox(width: 8.w),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContact(contactModel: widget.contactModel,)),
            );
          },
          child: Icon(Icons.edit),
        ),
      ],
    );
  }

  Future<File?> getImageFromDevice() async {
    // source can be ImageSource.gallery or ImageSource.camera

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Container buildImage() {
    return Container(
      height: 140.h,
      width: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: fileImage != null
              ? FileImage(fileImage!)
              : NetworkImage(widget.contactModel.image!) as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () async {
                // print("Image");
                fileImage = await getImageFromDevice();
                setState(() {});
              },
              child: Container(
                height: 40.h,
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15.r),
                  ),
                  color: AppColors.black.withValues(alpha: .5),
                ),
                child: Center(
                  child: Text(
                    AppString.change,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.inputLabel.copyWith(
                      color: AppColors.white.withValues(alpha: .7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Cleaner way to say "full width"
// Use MediaQuery if .sh is failing
