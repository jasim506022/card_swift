import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style/app_string.dart';
import '../../../common/widget/app_button.dart';

class ProfileActionsGroup extends StatelessWidget {
  const ProfileActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            onTap: () {
              // QR Code Logic
            },
            title: AppString.myQRCode,
            bgColor: Colors.white,
            textColor: Colors.blue,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AppButton(
            onTap: () {
              // Share Logic
            },
            title: AppString.share,
            bgColor: Colors.blue,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
