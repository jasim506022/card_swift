
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_text_style.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: .25.sh,

      width: double.infinity,

      decoration: BoxDecoration(color: Color(0xFF8BA18B)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                editableTextRow(title: "Md Jasim Uddin"),
                Column(
                  children: [
                    editableTextRow(
                      title: "Your Designation",
                      textStyle: AppTextStyle.medium.copyWith(
                        color: Colors.yellow,
                      ),
                    ),
                    editableTextRow(
                      title: "Your Company",
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

  Container buildImage() {
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
                color: Colors.black54, // semi-transparent overlay
              ),
              child: Center(
                child: Text(
                  "Change.....",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.medium.copyWith(color: Colors.white70),
                ),
              ),
            ),
          ),

          // Text with black shadow
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
}

// Cleaner way to say "full width"
// Use MediaQuery if .sh is failing
