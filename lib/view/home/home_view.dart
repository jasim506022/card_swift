import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../model/profile_model.dart';
import 'widget/business_description_section.dart';
import 'widget/camera_card.dart';
import 'widget/contact_input.dart';
import 'widget/heading_widget.dart';
import 'widget/profile_actions_group.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
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

              ProfileModel profileModel = ProfileModel.fromMap(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(profileModel: profileModel),
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
                              child: ContactInput(profileModel: profileModel),
                            ),

                            CameraCard(),
                            SizedBox(height: 15.h),
                            BusinessDescriptionSection(
                              descriptionText: profileModel.website ?? "",
                            ),

                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title:  Text("Sign Out", style: AppTextStyle.button.copyWith(color: AppColors.black),),
                              onTap: () {
                                Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text("Sign Out"),
                                    content: const Text(
                                      "Are you sure you want to sign out?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back(); // close dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          Get.back(); // close dialog first
                                          await Get.find<AuthController>()
                                              .signOut();
                                        },
                                        icon: const Icon(Icons.logout),
                                        label:  Text("Sign Out"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
}
