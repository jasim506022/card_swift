import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
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