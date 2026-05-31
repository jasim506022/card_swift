import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactTimestampRow extends StatelessWidget {
  // 1. Accept Cloud Firestore Timestamp directly
  final Timestamp timestamp;

  const ContactTimestampRow({super.key, required this.timestamp});

  // Helper function to get day suffix (st, nd, rd, th)
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
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
    String monthYearTime = DateFormat(
      "MMM yy, h:mm a",
    ).format(dateTime).toLowerCase(); // e.g., "apr 26, 12:00 pm"

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
