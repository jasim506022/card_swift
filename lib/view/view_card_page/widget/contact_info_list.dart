import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
