import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../common/widget/app_button.dart';
import '../../common/widget/custom_text_form_field.dart';
import '../../model/contact_model.dart';
import 'widget/custom_phone_number_field.dart';
import 'widget/heading_widget.dart';
import 'widget/input_field_row.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final businessController = TextEditingController();
  final emailController = TextEditingController();
  final altEmailController = TextEditingController();
  final phoneController = TextEditingController();

  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  var data = FirebaseFirestore.instance
      .collection("users")
      .doc(
        AppsConstant.sharedPreferences!.getString(
          AppString.uidSharedPreference,
        ),
      )
      .get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(
                AppsConstant.sharedPreferences!.getString(
                  AppString.uidSharedPreference,
                ),
              );

              print(snapshot.data!.data());

              final snapshotData = snapshot.data; // এটি একটি DocumentSnapshot
              final Map<String, dynamic> data =
                  snapshotData!.data() as Map<String, dynamic>;

              // এখন আপনি আপনার মডেলে ডাটা নিতে পারবেন
              ContactModel contact = ContactModel.fromMap(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reusable Profile Header
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
                            _buildHeaderButtons(),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: _buildContactInputs(),
                            ),

                            _buildCameraCard(),
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

  // Header Buttons Row
  Row _buildHeaderButtons() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            onTap: () {},
            title: AppString.myQRCode,
            bgColor: Colors.white,
            textColor: Colors.blue,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AppButton(
            onTap: () {},
            title: AppString.share,
            bgColor: Colors.blue,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // Contact Inputs Section
  Column _buildContactInputs() {
    return Column(
      children: [
        InputFieldRow(
          icon: Icons.email_outlined,
          child: CustomTextFormField(
            hintText: AppString.enterYourEmailHint,
            controller: emailController,
          ),
        ),
        InputFieldRow(
          icon: Icons.email_outlined,
          child: CustomTextFormField(
            hintText: AppString.alternativeEmailHint,
            controller: altEmailController,
          ),
        ),
        InputFieldRow(
          icon: Icons.phone_android_outlined,
          child: CustomPhoneNumberField(
            number: number,
            phoneController: phoneController,
          ),
        ),
      ],
    );
  }

  // Camera Card Section
  Widget _buildCameraCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.capturePersonalBusinessCard,
          style: AppTextStyle.bodyTitle,
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 25.h),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Column(
            children: [
              Icon(Icons.camera_alt, color: Colors.white, size: 35.h),
              Text(
                AppString.newCard,
                style: AppTextStyle.textBold.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
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
