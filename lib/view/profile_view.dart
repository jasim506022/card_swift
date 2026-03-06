import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../add_contract/add_contact.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = TextEditingController();
  String image =
      "https://scontent.fdac207-1.fna.fbcdn.net/v/t39.30808-6/634943180_943122718285707_2586458581799496460_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=100&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=08FyTwyyAHwQ7kNvwGLmW3F&_nc_oc=Adm6qTxvDWX1ibIX9MfWhCmFUBAaxfPv16EXJ1QCsvKPygca3Nbm5qJLNn41urUEm1pflg6xp-qi1l1wu-j7mg6x&_nc_zt=23&_nc_ht=scontent.fdac207-1.fna&_nc_gid=GiKOmV91fLQ8zu9xvLWXJg&_nc_ss=8&oh=00_AfyYtd7ARRYjShQeLaN_3t3r3ABZml53kArZbVu2680Xow&oe=69B0D318";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: .25.sh,
              // Use MediaQuery if .sh is failing
              width: double.infinity,
              // Cleaner way to say "full width"
              decoration: BoxDecoration(color: Colors.red),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Md Jasim Uddin",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Md Jasim Uddin",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Md Jasim Uddin",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ClipRRect(
                    // Use BorderRadius, not BorderRadiusGeometry
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      height: 140.h,
                      width: 100.h,
                      fit: BoxFit
                          .cover, // Essential to make the image fill the clipped area
                    ),
                  ),
                ],
              ),
            ),

      // --- INPUT SECTION ---
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Icon(Icons.email, color: Colors.red),
              SizedBox(width: 10.w),

              // FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
              Expanded(
                child: CustomTextFormField(
                  hintText: "Enter your email",
                  controller: textEditingController,
                ),
              ),
            ],
          ),
        ),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Icon(Icons.email, color: Colors.red),
                    SizedBox(width: 10.w),

                    // FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
                    Expanded(
                      child: CustomTextFormField(
                        hintText: "Enter your email",
                        controller: textEditingController,
                      ),
                    ),
                  ],
                ),
              ),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Icon(Icons.email, color: Colors.red),
                    SizedBox(width: 10.w),

                    // FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
                    Expanded(
                      child: CustomTextFormField(
                        hintText: "Enter your email",
                        controller: textEditingController,
                      ),
                    ),
                  ],
                ),
              ),),

            Text("Capture Personal Business Card"),
            Icon(Icons.dangerous),
            Text("Capture Personal Business Card"),
          ],
        ),
      ),
    );
  }
}
