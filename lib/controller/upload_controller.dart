import 'dart:io';

import 'package:card_swift/common/style/app_function.dart';
import 'package:card_swift/repository/upload_document_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../add_contract/example/contact_form_controller.dart';
import '../common/style/app_string.dart';
import '../model/contact_model.dart';

class UploadController extends GetxController {
  final UploadDocumentRepository repository;
  var selectPhoto = Rx<File?>(null);

  final picker = ImagePicker();

  UploadController({required this.repository});

  Future<void> upLoadImage() async {
    repository.uploadImage(selectPhoto.value!.path);
  }

  Future<void> uploadImageFromCamera() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectPhoto.value = File(pickedFile.path);
    } else {
      Get.snackbar(
        "Error",
        "No image selected",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveData(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
  ) async {
    // var image = await repository.uploadImage(selectPhoto.value!.path);

    final mobiles = formController.mobileControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final phones = formController.phoneControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final emails = formController.emailControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final contact = ContactModel(
      firstName: controllers[AppString.hintFirstName]!.text,
      lastName: controllers[AppString.hintLastName]!.text,
      jobTitle: controllers[AppString.hintJobTitle]!.text,
      companyName: controllers[AppString.hintCompanyName]!.text,
      description: controllers[AppString.hintDescription]!.text,

      mobileNumbers: mobiles,

      phoneNumber: phones,

      email: emails,

      image: "image",
      street: controllers[AppString.hintStreetName]!.text,
      city: controllers[AppString.hintCity]!.text,
      zipCode: controllers[AppString.hintZipCode]!.text,
      country: controllers[AppString.hintCountry]!.text,
      whatsapp: controllers[AppString.hintWhatsapp]!.text,
      website: controllers[AppString.hintWebsite]!.text,
      facebook: controllers[AppString.hintFacebook]!.text,
      createdAt: Timestamp.now(),
    );

    FirebaseFirestore.instance
        .collection("cardss")
        .doc("idsss")
        .set(contact.toMap());
    AppFunction.flutterToast(msg: "Successfully");
  }
}
