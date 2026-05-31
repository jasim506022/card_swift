import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/style/app_function.dart';
import '../../../common/style/app_text_style.dart';
import '../../../common/style/apps_constant.dart';
import '../../../common/widget/menu_card.dart';
import '../../../model/contact_model.dart';
import '../../../route/route_name.dart';
import 'info_text.dart';

class VisitingCard extends StatelessWidget {
  const VisitingCard({super.key, required this.contact});

  final ContactModel contact;

  String get _imageUrl {
    final image = contact.image;
    return (image?.isNotEmpty ?? false) ? image! : AppsConstant.defaultImage;
  }

  String get _fullName =>
      '${contact.firstName ?? ''} ${contact.lastName ?? ''}'.trim();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouteName.viewCard, arguments: contact),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopRow(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    AppFunction.formatTimestamp(contact.createdAt),
                    style: AppTextStyle.small,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: Image.network(
        _imageUrl,
        width: .35.sw,
        height: .10.sh,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return Container(
            width: .35.sw,
            height: .10.sh,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoText(text: _fullName, style: AppTextStyle.bodyTitle),

              SizedBox(height: 5.h),

              InfoText(
                text:
                    '${contact.jobTitle ?? ''} | ${contact.description ?? ''}',
                style: AppTextStyle.body,
              ),

              InfoText(
                text: contact.companyName ?? '',
                style: AppTextStyle.body,
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        CardMenu(contact: contact),
      ],
    );
  }
}
