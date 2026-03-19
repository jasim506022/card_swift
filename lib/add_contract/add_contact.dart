import 'package:card_swift/common/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/widget/custom_text_form_field.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Add Contact"), actions: [Text("Save")]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100
                          , shape: BoxShape.circle
                    ),
                    child: Icon(Icons.person_outline, size: 50.h)),
                Text("Add Picture", style: AppTextStyle.bodyTitle,),
              ],
            ),

            CustomTextFormField(
              hintText: "First Name",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Last name",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Job Title",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Company Name",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Description",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Mobile Number",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Phone Number",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Email Address",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Fax",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "P.O. Box",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "Street Name",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "City ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "State ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "ZIP Code ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "Country ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "Whatsapp  ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "Website ",
              controller: textEditingController,
            ),
            CustomTextFormField(
              hintText: "Facebook ",
              controller: textEditingController,
            ),
          ],
        ),
      ),
    );
  }
}
