import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/style/app_string.dart';
import '../../common/style/app_text_style.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../controller/auth_controller.dart';
import '../../model/contact_model.dart';
import 'widget/camera_card.dart';
import 'widget/contact_input.dart';
import 'widget/heading_widget.dart';
import 'widget/profile_actions_group.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final businessController = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: authController.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              final Map<String, dynamic> data =
                  snapshotData!.data() as Map<String, dynamic>;

              ContactModel contact = ContactModel.fromMap(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(contactModel: contact),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 15.w,
                          vertical: 25.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileActionsGroup(),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: ContactInput(contactModel: contact),
                            ),

                            CameraCard(),
                            SizedBox(height: 15.h),
                            _buildBusinessDescription(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  // Business Description Section
  Widget _buildBusinessDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.addServicesYourOffer, style: AppTextStyle.heading),
        SizedBox(height: 10.h),
        CustomTextFormField(
          hintText: AppString.tellUsAboutYourBusiness,
          controller: businessController,
          maxLines: 2,
          textInputType: TextInputType.multiline,
        ),
      ],
    );
  }
}

/*
  // Contact Inputs Section
  Column _buildContactInputs(ContactModel contact) {
    return Column(
      children: [
        /// ১. ইমেইল লিস্ট হ্যান্ডলিং (যদি ইমেইল লিস্ট হয়)
        if (contact.email != null && contact.email!.isNotEmpty)
          ...contact.email!.map((email) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: InputFieldRow(
                icon: Icons.email_outlined,
                // child: _buildDisplayContainer(email),
                text: email,
              ),
            );
          })
        else
          // যদি লিস্ট না থাকে বা খালি থাকে তবে একটি ডিফল্ট মেসেজ
          InputFieldRow(icon: Icons.email_outlined, text: "No email available"),

        /// ১. ইমেইল লিস্ট হ্যান্ডলিং (যদি ইমেইল লিস্ট হয়)
        if (contact.mobileNumbers != null && contact.mobileNumbers!.isNotEmpty)
          ...contact.mobileNumbers!.map((mobileNumber) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: InputFieldRow(icon: Icons.phone, text: mobileNumber),
            );
          })
        else
          // যদি লিস্ট না থাকে বা খালি থাকে তবে একটি ডিফল্ট মেসেজ
          InputFieldRow(icon: Icons.phone, text: "No email available"),
      ],
    );
  }


   */
