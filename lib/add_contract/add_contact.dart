import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/custom_text_form_field.dart';

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
      appBar: AppBar(title: Text("Add Contact"), actions: [Text("Save")]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [Icon(Icons.percent), Text("Add Picture")]),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),

            CustomTextFormField(
              hintText: "How are u",
              controller: textEditingController,
            ),
          ],
        ),
      ),
    );
  }
}
