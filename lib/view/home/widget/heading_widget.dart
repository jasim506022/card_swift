import 'package:card_swift/model/profile_model.dart';
import 'package:card_swift/view/edit_profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_string.dart';
import '../../../common/style/app_text_style.dart';
import '../../../common/style/apps_constant.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.profileModel});

  final ProfileModel profileModel;

  void _goToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(profileModel: profileModel),
      ),
    );
  }

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
                _editableTextRow(
                  context: context,
                  title:
                      "${profileModel.firstName}${profileModel.lastName ?? ""}",
                ),
                Column(
                  children: [
                    _editableTextRow(
                      context: context,
                      title: profileModel.jobTitle ?? AppString.appDesignation,
                      textStyle: AppTextStyle.bodyTitle.copyWith(
                        color: AppColors.yellow,
                        fontSize: 15.sp,
                      ),
                    ),
                    _editableTextRow(
                      context: context,
                      title: profileModel.companyName ?? AppString.companyName,
                      textStyle: AppTextStyle.mediumNormal,
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildImage(context),
        ],
      ),
    );
  }

  Row _editableTextRow({
    required String title,
    required BuildContext context,
    TextStyle? textStyle,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: textStyle ?? AppTextStyle.subSmallTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 8.w),
        InkWell(onTap: () => _goToEdit(context), child: Icon(Icons.edit)),
      ],
    );
  }

  Container buildImage(BuildContext context) {
    return Container(
      height: 140.h,
      width: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(profileModel.image ?? AppsConstant.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () => _goToEdit(context),
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
