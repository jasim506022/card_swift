import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/widget/menu_card.dart';
import '../../model/contact_model.dart';
import '../../route/route_name.dart';
import 'widget/contact_header_section.dart';
import 'widget/contact_info_list.dart';
import 'widget/contact_timestamp_row.dart';
import 'widget/quick_actions_bar.dart';

class ViewCardPage extends StatelessWidget {
  const ViewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactModel contactModel = Get.arguments;
    return Scaffold(
      appBar: _buildAppBar(contactModel),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: .2.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                contactModel.image ?? AppsConstant.defaultImage,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15.h),
            ContactHeaderSection(contact: contactModel),
            SizedBox(height: 10.h),
            Divider(),
            QuickActionsBar(),
            ContactInfoList(
              items: contactModel.mobileNumbers!,
              icon: Icons.phone_android_rounded,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),

            ContactInfoList(
              items: contactModel.phoneNumber!,
              icon: Icons.phone,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),

            ContactInfoList(
              items: contactModel.email!,
              icon: Icons.alternate_email_rounded,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "Address",
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "${contactModel.street!} ${contactModel.city!} ${contactModel.country!} ${contactModel.zipCode!}",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "About ${contactModel.firstName!}${contactModel.lastName!}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              " ${contactModel.website!}",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "Capture Time ",
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            ContactTimestampRow(
              // Use a fallback timestamp if the field is null in your DB
              timestamp: contactModel.createdAt ?? Timestamp.now(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(ContactModel contactModel) {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {
            Get.toNamed(
              RouteName.addCard,
              arguments: {'contactModel': contactModel, 'isEdit': true},
            );
          },

          child: Text(AppString.edit, style: TextStyle(color: AppColors.blue)),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined),
        ),
        CardMenu(contact: contactModel),

        SizedBox(width: 20.w),
      ],
    );
  }
}
