import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style/app_text_style.dart';
import '../../../model/menu_model.dart';

class MenuGridItem extends StatelessWidget {
  const MenuGridItem({super.key, required this.menuItem});

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: menuItem.color,
            shape: BoxShape.circle,
          ),
          child: Icon(menuItem.icon, size: 30.h, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text(
          menuItem.title,
          textAlign: TextAlign.center,
          style: AppTextStyle.smallBody,
        ),
      ],
    );
  }
}
