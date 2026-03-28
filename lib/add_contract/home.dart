import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/common/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/auth_controller.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();

  int selectedIndex = 0;
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  final List<String> tabs = ["Contacts", "Verifying"];

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
              /*
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
                            fontSize: 16.sp,
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
                  const SizedBox(width: 15), // Space between buttons
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
                            fontSize: 16.sp,
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
*/
              // Optional horizontal line
              // 3. The Content Area
              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: selectedIndex == 0
                    ? ContactList(contacts: contacts)
                    : Text("Bangladesh"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisitingCard extends StatelessWidget {
  const VisitingCard({super.key, required this.contact});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVisitImage(),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topRow(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("30st Jan 26, 12:54Pm", style: AppTextStyle.small),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 🔹 Text Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Md Jasim Uddin",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.bodyTitle,
              ),
              SizedBox(height: 5.h),
              Text(
                "Professor | Dep odfadfaffv",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.body,
              ),
              Text(
                "University Internation",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.body,
              ),
            ],
          ),
        ),
        // 🔹 Menu Icon
        SizedBox(width: 20.w),
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          child: FaIcon(size: 30.h, FontAwesomeIcons.ellipsis),
        ),
      ],
    );
  }

  Container _buildVisitImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdqpdEN5cM_sGSv0B0W5vFfCroA3d-x-mPZg&s",
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      height: .10.sh,
      width: .35.sw,
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔹 Text Button
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // remove default padding
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // 🔹 Animated Underline (adaptive width)
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 3.h,
          width: isSelected ? 100.w : 0, // responsive instead of fixed 100
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // why use ShrinkWrap
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      // prevents scroll conflict
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 25.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return MenuGridItem(item: item);
      },
    );
  }
}

class MenuGridItem extends StatelessWidget {
  const MenuGridItem({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
          child: Icon(item.icon, size: 30.h, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: AppTextStyle.smallBody,
        ),
      ],
    );
  }
}

class MenuItem {
  final IconData icon;
  final Color color;
  final String title;

  MenuItem({required this.icon, required this.color, required this.title});
}

final List<MenuItem> menuItems = [
  MenuItem(icon: Icons.group, color: Colors.blue, title: "Groups (1)"),
  MenuItem(
    icon: Icons.person_add_alt_1,
    color: Colors.orange,
    title: "Add Contact",
  ),
  MenuItem(icon: Icons.handshake, color: Colors.red, title: "Team"),
  MenuItem(icon: Icons.open_in_new, color: Colors.pink, title: "Export"),
  MenuItem(icon: Icons.arrow_upward, color: Colors.blue, title: "Import"),
  MenuItem(icon: Icons.dashboard, color: Colors.green, title: "CRM"),
];

class ContactModel {
  final String name;
  final String role;
  final String university;
  final String imageUrl;
  final String date;

  const ContactModel({
    required this.name,
    required this.role,
    required this.university,
    required this.imageUrl,
    required this.date,
  });
}

final List<ContactModel> contacts = [
  ContactModel(
    name: "Md Jasim Uddin",
    role: "Professor | Dep odfadfaffv",
    university: "University International",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdqpdEN5cM_sGSv0B0W5vFfCroA3d-x-mPZg&s",
    date: "30 Jan 26, 12:54 PM",
  ),
];

class ContactList extends StatelessWidget {
  final List<ContactModel> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        return VisitingCard(contact: contacts[index]);
      },
    );
  }
}
