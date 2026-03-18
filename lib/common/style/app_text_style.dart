import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // App Name Text Title
  static TextStyle appNameTitle = GoogleFonts.alfaSlabOne(
    fontSize: 24.sp,
    color: Colors.green,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
  );

  static TextStyle appBarTitle = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black, // or white depending on theme
  );

  // Main page title
  static TextStyle title = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  // Secondary title / screen header
  static TextStyle subTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // Section headings inside a page
  static TextStyle sectionTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // Paragraph / body text
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  // Small body / description / info text
  static TextStyle smallBody = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[700],
  );

  // Caption / helper text
  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[500],
  );

  // Button text
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  // Input field hint text
  static TextStyle inputHint = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[400],
  );

  // Input field label
  static TextStyle inputLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  // Small label / tag
  static TextStyle tag = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Error message text
  static TextStyle error = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );

  // Link / clickable text
  static TextStyle link = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  static TextStyle heading = GoogleFonts.poppins(
    color: Colors.black87,
    fontWeight: FontWeight.w800,
    fontSize: 20.sp,
  );

  /*
  static TextStyle title = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );



   */

  static TextStyle medium = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle mediumNormal = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle textBold = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle hint = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: Colors.grey,
    fontWeight: FontWeight.w600,
  );
}
