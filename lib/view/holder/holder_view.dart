import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/contact_list.dart';
import 'widget/custom_tab.dart';
import 'widget/menu_grid.dart';

class HolderView extends StatefulWidget {
  const HolderView({super.key});

  @override
  State<HolderView> createState() => _HolderViewState();
}

class _HolderViewState extends State<HolderView>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();

  int selectedIndex = 0;

  final List<String> tabs = ["Contacts", "Verifying"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: AppString.searchCards,
                  controller: textEditingController,
                ),
                SizedBox(height: 10.h),
                MenuGrid(),
                Divider(color: Colors.grey),
                Row(
                  children: List.generate(
                    tabs.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: CustomTab(
                        title: tabs[index],
                        isSelected: selectedIndex == index,
                        onTap: () => setState(() => selectedIndex = index),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                SizedBox(
                  width: double.infinity,
                  child: selectedIndex == 0 ? ContactList() : Text("Coming"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
