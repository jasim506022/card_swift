import 'dart:io';

import 'package:card_swift/model/profile_model.dart';
import 'package:card_swift/route/route_name.dart';
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
  final CloudinaryUploaderRepository repository =
      CloudinaryUploaderRepository();

  final FirebaseUploadRepository firebaseUploadRepository =
      FirebaseUploadRepository();

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

  final RxBool isSaving = false.obs;

  /// 💾 Save Contact
  Future<void> saveProfile(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String images,
  ) async {
    isSaving.value = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Saving data, please wait...",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
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

      var image = await uploadImage() ?? images;

      print("object $image");

      final contact = _buildContactModel(
        controllers,
        mobiles,
        phones,
        emails,
        image,
      );
      await firebaseUploadRepository.updateUserProfile(contact: contact);

      Get.back(); // লোডিং ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Successfully");
      Get.offAndToNamed(RouteName.mainPage);
    } catch (e) {
      Get.back(); // এরর আসলে ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Failed to save data: $e");
      print("Firebase Upload Error: $e");
    } finally {
      // কাজ শেষ বা এরর যাই হোক, সেভিং স্ট্যাটাস ফলস করে লক খুলে দেওয়া হবে
      isSaving.value = false;
    }
  }

  /// 💾 Save Contact
  Future<void> saveContact(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String images,
  ) async {
    isSaving.value = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Saving data, please wait...",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
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

      var image = await uploadImage() ?? images;

      print("object $image");

      // if (isPorifleUpdate) {
      //   final contact = _buildContactModel(
      //     controllers,
      //     mobiles,
      //     phones,
      //     emails,
      //     image,
      //   );
      //   await firebaseUploadRepository.updateUserProfile(contact: contact);
      // } else {

      final contact = _buildForCard(
        controllers,
        mobiles,
        phones,
        emails,
        image,
      );
      await firebaseUploadRepository.postCard(contact: contact);
      // }

      Get.back(); // লোডিং ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Successfully");
      Get.offAndToNamed(RouteName.homePage);
    } catch (e) {
      Get.back(); // এরর আসলে ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Failed to save data: $e");
      print("Firebase Upload Error: $e");
    } finally {
      // কাজ শেষ বা এরর যাই হোক, সেভিং স্ট্যাটাস ফলস করে লক খুলে দেওয়া হবে
      isSaving.value = false;
    }
  }

  ProfileModel _buildContactModel(
    Map<String, TextEditingController> controllers,
    List<String> mobiles,
    List<String> phones,
    List<String> emails,
    String image,
  ) {
    return ProfileModel(
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

  ContactModel _buildForCard(
    Map<String, TextEditingController> controllers,
    List<String> mobiles,
    List<String> phones,
    List<String> emails,
    String image,
  ) {
    return ContactModel(
      uid: Timestamp.now().millisecondsSinceEpoch.toString(),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
