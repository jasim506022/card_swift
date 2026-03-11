import 'package:card_swift/core/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../add_contract/add_contact.dart';
import 'app_button.dart';
import 'custom_text_form_field.dart';
import 'heading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = TextEditingController();
  String image =
      "https://scontent.fdac207-1.fna.fbcdn.net/v/t39.30808-6/634943180_943122718285707_2586458581799496460_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=100&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=08FyTwyyAHwQ7kNvwGLmW3F&_nc_oc=Adm6qTxvDWX1ibIX9MfWhCmFUBAaxfPv16EXJ1QCsvKPygca3Nbm5qJLNn41urUEm1pflg6xp-qi1l1wu-j7mg6x&_nc_zt=23&_nc_ht=scontent.fdac207-1.fna&_nc_gid=GiKOmV91fLQ8zu9xvLWXJg&_nc_ss=8&oh=00_AfyYtd7ARRYjShQeLaN_3t3r3ABZml53kArZbVu2680Xow&oe=69B0D318";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final altEmailController = TextEditingController();
  final phoneController = TextEditingController();

  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingWidget(image: image),
              SizedBox(height: 50),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: "MY QR CODE",
                            bgColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: AppButton(
                            title: "Share",
                            borderColor: Colors.blue,
                            bgColor: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- INPUT SECTION ---
              SizedBox(height: 30.h),

              Column(
                children: [
                  InputFieldRow(
                    icon: Icons.email_outlined,
                    child: CustomTextFormField(
                      hintText: "Enter your email",
                      controller: emailController,
                    ),
                  ),
                  InputFieldRow(
                    icon: Icons.email_outlined,
                    child: CustomTextFormField(
                      hintText: "Alternate Email Address",
                      controller: altEmailController,
                    ),
                  ),
                  InputFieldRow(
                    icon: Icons.phone_android_outlined,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 10,
                      ),
                      initialValue: number,
                      textFieldController: phoneController,
                      formatInput: false,
                      inputDecoration:
                          CustomTextFieldDecoration.inputDecoration(
                            hintText: "Enter Your Phone Number",
                          ),
                    ),
                  ),
                ],
              ),

              Text(
                "Capture Personal Business Card",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white, size: 35.h),
                    Text(
                      "New Card",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Capture Personal Business Card",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFieldRow extends StatelessWidget {
  const InputFieldRow({super.key, required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black54, size: 45.h),
          SizedBox(width: 20.w),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// FIX: Wrap CustomTextFormField in Expanded to prevent the "hasSize" error
