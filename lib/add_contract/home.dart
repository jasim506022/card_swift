import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_text_style.dart';
import 'package:card_swift/common/widget/custom_text_form_field.dart';
import 'package:card_swift/model/contact_model.dart';
import 'package:card_swift/view/main/view_card_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/auth_controller.dart';
import '../controller/card_list_controller.dart';
import '../view/add_contact/add_contact.dart';

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
          child: SingleChildScrollView(
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

                // Optional horizontal line
                // 3. The Content Area
                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: selectedIndex == 0
                      ? ContactList()
                      : Text("Bangladesh"),
                ),
              ],
            ),
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ViewCardPage(contactModel: contact)),
        );
      },
      child: Row(
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
                  child: Text(
                    formatTimestamp(contact.createdAt),
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
                contact.firstName! + contact.lastName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.bodyTitle,
              ),
              SizedBox(height: 5.h),
              Text(
                "${contact.jobTitle} | ${contact.description}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.body,
              ),
              Text(
                contact.companyName!,
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
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
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
            contact.image == ""
                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdqpdEN5cM_sGSv0B0W5vFfCroA3d-x-mPZg&s"
                : contact.image!,
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

class ContactList extends StatelessWidget {
  // final List<ContactModel>? contacts;

  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CardListController());

    return Obx(() {
      if (controller.isListLoading.value && controller.allCards.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // ২. যদি ডাটাবেজ একদম খালি থাকে
      if (controller.allCards.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("No business cards saved yet."),
          ),
        );
      }

      // ৩. লাইভ ডাটা থাকলে এই লিস্টটি বিল্ড হবে
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.allCards.length,
        // এখানে ডাইনামিক কাউন্ট হবে
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          // রিয়েল-টাইম লিস্ট থেকে নির্দিষ্ট কার্ডের মডেলটি নেওয়া হচ্ছে
          final cardModel = controller.allCards[index];

          // আপনার VisitingCard যদি ContactModel এক্সপেক্ট করে,
          // তবে কার্ড মডেলটিকে এভাবে পাস করতে পারেন (অথবা টাইপ কনভার্ট করে)
          return VisitingCard(contact: cardModel);
        },
      );
    });
  }
}

String formatTimestamp(Timestamp? timestamp) {
  if (timestamp == null) return "";

  // ১. Timestamp থেকে DateTime অবজেক্ট তৈরি
  DateTime date = timestamp.toDate();

  // ২. মাসের সংক্ষিপ্ত রূপ বের করা (Manual Array)
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  String monthStr = months[date.month - 1];

  // ৩. তারিখের সাফিক্স (st, nd, rd, th) বের করার লজিক
  String suffix = "th";
  int day = date.day;
  if (day >= 11 && day <= 13) {
    suffix = "th";
  } else {
    switch (day % 10) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
    }
  }

  // ৪. ১২ ঘণ্টার ফরম্যাটে আওয়ার এবং Pm/Am বের করা
  int hour = date.hour % 12;
  if (hour == 0) hour = 12; // ১২টা বাজলে ০ এর জায়গায় ১২ দেখাবে
  String minuteStr = date.minute.toString().padLeft(
    2,
    '0',
  ); // মিনিট সিঙ্গেল ডিজিট হলে বামে ০ বসবে
  String period = date.hour >= 12 ? "Pm" : "Am";

  // ৫. বছরের শেষ ২ ডিজিট নেওয়া (যেমন: 2026 থেকে 26)
  String yearStr = date.year.toString().substring(2);

  // সবশেষে আপনার ফরম্যাট অনুযায়ী জোড়া দেওয়া
  return "$day$suffix $monthStr $yearStr, $hour:$minuteStr$period";
}
