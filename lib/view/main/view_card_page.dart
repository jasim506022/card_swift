import 'package:card_swift/common/style/app_colors.dart';
import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../model/contact_model.dart';

class ViewCardPage extends StatelessWidget {
  const ViewCardPage({super.key, required this.contactModel});

  final ContactModel contactModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: .2.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                contactModel.image ?? AppsConstant.defaultCardBackground,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 80.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.person_outline, size: 40.h),
                  ),

                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${contactModel.firstName!} ${contactModel.lastName!}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          contactModel.jobTitle!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          contactModel.companyName!,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Divider(),
            QuickActionsBar(),
            ContactInfoList(
              items: contactModel.mobileNumbers!,
              icon: Icons.phone_android_rounded,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),

            ContactInfoList(
              items: contactModel.phoneNumber!,
              icon: Icons.phone,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),

            ContactInfoList(
              items: contactModel.email!,
              icon: Icons.alternate_email_rounded,
              onItemTap: (value) {
                print('Tapped Phone: $value');
              },
            ),

            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "Address",
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "${contactModel.street!} ${contactModel.city!} ${contactModel.country!} ${contactModel.zipCode!}",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "About ${contactModel.firstName!}${contactModel.lastName!}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(" ${contactModel.website!}", style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 15.h),
            Text(
              "Capture Time ", style: GoogleFonts.poppins(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),

            ),
            ContactTimestampRow(
              // Use a fallback timestamp if the field is null in your DB
              timestamp: contactModel.createdAt ?? Timestamp.now(),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(AppString.edit, style: TextStyle(color: AppColors.blue)),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(size: 25.h, FontAwesomeIcons.ellipsis),
        ),

        SizedBox(width: 20.w),
      ],
    );
  }
}

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext Listcontext) {
    // 1. Define the data for the action items
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.phone,
        'label': 'Call',
        'color': const Color(0xFF2ecc71), // Vibrant Green
        'onTap': () => print('Call tapped'),
      },
      {
        'icon': Icons.email,
        'label': 'Email',
        'color': const Color(0xFFf39c12), // Vibrant Orange
        'onTap': () => print('Email tapped'),
      },
      {
        'icon': Icons.note_alt_rounded,
        'label': 'Notes',
        'color': const Color(0xFF3498db), // Bright Cyan/Blue
        'onTap': () => print('Notes tapped'),
      },
      {
        'icon': Icons.share,
        'label': 'Share',
        'color': const Color(0xFF1a73e8), // Deep Blue
        'onTap': () => print('Share tapped'),
      },
    ];

    // 2. Render the horizontal layout
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((item) {
          return InkWell(
            onTap: item['onTap'],
            borderRadius: BorderRadius.circular(30), // Smooth ripple shape
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circular background container for the icon
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: item['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'], color: Colors.white, size: 26),
                  ),
                  const SizedBox(height: 6),
                  // Action Label text
                  Text(
                    item['label'],
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ContactInfoList extends StatelessWidget {
  // 2. Pass them through the constructor
  const ContactInfoList({
    super.key,
    required this.items,
    required this.icon,
    this.onItemTap,
  });

  final List<String> items;
  final IconData icon;
  final Function(String)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length, // Uses the length of the passed array
      itemBuilder: (context, index) {
        final itemValue = items[index];

        return InkWell(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(itemValue); // Passes back the clicked string value
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Uses the single icon passed from the constructor
                Icon(icon, color: Colors.grey.shade500, size: 28),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    itemValue,
                    style: GoogleFonts.poppins(
                      color: Color(0xFF1a73e8),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




class ContactTimestampRow extends StatelessWidget {
  // 1. Accept Cloud Firestore Timestamp directly
  final Timestamp timestamp;

  const ContactTimestampRow({
    super.key,
    required this.timestamp,
  });

  // Helper function to get day suffix (st, nd, rd, th)
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 2. Convert Firestore Timestamp to standard DateTime object
    DateTime dateTime = timestamp.toDate();

    // 3. Format the data to match your UI image
    String dayName = DateFormat('E').format(dateTime); // e.g., "Wed"
    String dayNumber = DateFormat('d').format(dateTime); // e.g., "15"
    String suffix = _getDaySuffix(dateTime.day); // e.g., "th"
    String monthYearTime = DateFormat("MMM yy, h:mm a").format(dateTime).toLowerCase(); // e.g., "apr 26, 12:00 pm"

    // Combined string: "Wed, 15th Apr 26, 12:00 pm"
    String formattedText = "$dayName, $dayNumber$suffix $monthYearTime";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time_rounded,
            color: Colors.grey.shade500,
            size: 26,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              formattedText,
              style: const TextStyle(
                color: Color(0xFF2C2C2C),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
