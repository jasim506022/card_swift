import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/common/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText: "Search Cards",
                controller: textEditingController,
              ),
              SizedBox(height: 30.h),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.people_outline,
                          size: 25.h,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text("Bangladesh", style: AppTextStyle.textBold),
                    ],
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      TextButton(
                        onPressed: () => setState(() => selectedIndex = 0),
                        child: Text(
                          "Contacts",
                          style: TextStyle(
                            color: selectedIndex == 0
                                ? Colors.blue
                                : Colors.grey,
                            fontWeight: selectedIndex == 0
                                ? FontWeight.w900
                                : FontWeight.normal,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        // Smooth transition
                        margin: const EdgeInsets.only(top: 4),
                        // Space between text and line
                        height: 3,
                        width: selectedIndex == 0 ? 100 : 0,
                        // Line grows/shrinks
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20), // Space between buttons
                  Column(
                    children: [
                      TextButton(
                        onPressed: () => setState(() => selectedIndex = 1),
                        child: Text(
                          "Verifying",
                          style: TextStyle(
                            color: selectedIndex == 1
                                ? Colors.blue
                                : Colors.grey,
                            fontWeight: selectedIndex == 1
                                ? FontWeight.w900
                                : FontWeight.normal,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        // Smooth transition
                        margin: const EdgeInsets.only(top: 4),
                        // Space between text and line
                        height: 3,
                        width: selectedIndex == 1 ? 100 : 0,
                        // Line grows/shrinks
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Optional horizontal line
              // 3. The Content Area
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                color: Colors.grey[100],
                child: selectedIndex == 0
                    ? Container(
                        height: .13.sh,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: .1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              height: .13.sh,
                              width: .35.sw,
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                // 1. Pushes text to the TOP
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // 2. Aligns text to the LEFT
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Md Jasim Uddin",
                                            style: AppTextStyle.medium,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text("Professor | Computer"),
                                          Text("University Internation"),
                                        ],
                                      ),
                                      FaIcon(FontAwesomeIcons.ellipsis),
                                    ],
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "University Internation",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text("Bangladesh"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
