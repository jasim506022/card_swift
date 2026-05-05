import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'contact_form_controller.dart';
import '../common/style/app_function.dart';
import '../common/style/app_string.dart';
import '../model/contact_model.dart';
import '../repository/cloudinary_uploader_repository.dart';
import '../repository/firebase_upload_repository.dart';

class UploadController extends GetxController {
  final CloudinaryUploaderRepository repository;

  final FirebaseUploadRepository firebaseUploadRepository =
      FirebaseUploadRepository();

  UploadController({required this.repository});

  final picker = ImagePicker();
  final Rx<File?> selectedPhoto = Rx<File?>(null);

  /// ☁️ Upload Image (optional use)
  Future<String?> uploadImage() async {
    final file = selectedPhoto.value;
    if (file == null) return null;

    return await repository.uploadImage(file.path);
  }

  /// 📸 Pick Image
  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      selectedPhoto.value = File(picked.path);
    } else {
      Get.snackbar(
        "Error",
        "No image selected",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 💾 Save Contact
  Future<void> saveContact(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String images,
  ) async {
    // var image = await repository.uploadImage(selectedPhoto.value!.path);

    // image ?? images;

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

    final contact = _buildContactModel(
      controllers,
      mobiles,
      phones,
      emails,
      images,
    );
    firebaseUploadRepository.updateUserProfile(contact: contact);
    AppFunction.flutterToast(msg: "Successfully");
  }

  ContactModel _buildContactModel(
    Map<String, TextEditingController> controllers,
    List<String> mobiles,
    List<String> phones,
    List<String> emails,
    String? image,
  ) {
    return ContactModel(
      firstName: controllers[AppString.hintFirstName]!.text,
      lastName: controllers[AppString.hintLastName]!.text,
      jobTitle: controllers[AppString.hintJobTitle]!.text,
      companyName: controllers[AppString.hintCompanyName]!.text,
      description: controllers[AppString.hintDescription]!.text,
      mobileNumbers: mobiles,
      phoneNumber: phones,
      email: emails,
      image: image,
      street: controllers[AppString.hintStreetName]!.text,
      city: controllers[AppString.hintCity]!.text,
      zipCode: controllers[AppString.hintZipCode]!.text,
      country: controllers[AppString.hintCountry]!.text,
      whatsapp: controllers[AppString.hintWhatsapp]!.text,
      website: controllers[AppString.hintWebsite]!.text,
      facebook: controllers[AppString.hintFacebook]!.text,
      createdAt: Timestamp.now(),
    );
  }
}
