import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/style/app_text_style.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String image =
        "https://img.freepik.com/premium-photo/corporate-portrait-proud-with-business-man-office-start-professional-career-as-intern-company-confident-suit-with-smile-formal-employee-workplace-administration_590464-381909.jpg?semt=ais_hybrid&w=740&q=80";

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
                editableTextRow(title: AppString.appProfileName),
                Column(
                  children: [
                    editableTextRow(
                      title: AppString.appDesignation,
                      textStyle: AppTextStyle.medium.copyWith(
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

          buildImage(image),
        ],
      ),
    );
  }

  Row editableTextRow({required String title, TextStyle? textStyle}) {
    return Row(
      children: [
        Text(title, style: textStyle ?? AppTextStyle.title),
        SizedBox(width: 8.w),
        Icon(Icons.edit),
      ],
    );
  }

  Container buildImage(String image) {
    return Container(
      height: 140.h,
      width: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
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
                  style: AppTextStyle.medium.copyWith(
                    color: AppColors.white.withValues(alpha: .7),
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
