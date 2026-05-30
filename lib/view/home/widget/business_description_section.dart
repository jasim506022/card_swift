import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/style/app_string.dart';
import '../../../common/style/app_text_style.dart';

class BusinessDescriptionSection extends StatelessWidget {
  final String descriptionText;

  const BusinessDescriptionSection({super.key, required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(AppString.addServicesYourOffer, style: AppTextStyle.heading),
        SizedBox(height: 10.h),

        // Description Text Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey[100], // Soft background color
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            descriptionText.isNotEmpty
                ? descriptionText
                : AppString.tellUsAboutYourBusiness,
            // Fallback if text is empty
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: descriptionText.isNotEmpty ? Colors.black87 : Colors.grey,
              height: 1.4, // Improves readability for multi-line text
            ),
          ),
        ),
      ],
    );
  }
}
