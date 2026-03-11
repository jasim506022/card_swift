import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle title = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
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
}
