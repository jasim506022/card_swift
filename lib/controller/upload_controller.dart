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

/*
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
      Get.offAndToNamed(RouteName.mainPage);
    } catch (e) {
      Get.back(); // এরর আসলে ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Failed to save data: $e");
      print("Firebase Upload Error: $e");
    } finally {
      isSaving.value = false;
    }
  }

  /// 💾 Save Contact
  Future<void> updateCard(
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

      final contact = _buildUpdateCard(
        controllers,
        mobiles,
        phones,
        emails,
        image,
      );
      await firebaseUploadRepository.updateCard(contact: contact);
      // }

      Get.back(); // লোডিং ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Update Successfully");
      Get.offAndToNamed(RouteName.mainPage);
    } catch (e) {
      Get.back(); // এরর আসলে ডায়ালগ রিমুভ
      AppFunction.flutterToast(msg: "Failed to save data: $e");
      print("Firebase Upload Error: $e");
    } finally {
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

  ContactModel _buildUpdateCard(
      Map<String, TextEditingController> controllers,
      List<String> mobiles,
      List<String> phones,
      List<String> emails,
      String image,
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


 */

class UploadController extends GetxController {
  final CloudinaryUploaderRepository repository =
      CloudinaryUploaderRepository();

  final FirebaseUploadRepository firebaseUploadRepository =
      FirebaseUploadRepository();

  final picker = ImagePicker();

  final Rx<File?> selectedPhoto = Rx<File?>(null);
  final RxBool isSaving = false.obs;

  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      selectedPhoto.value = File(picked.path);
      return;
    }

    Get.snackbar(
      "Error",
      "No image selected",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<String?> uploadImage() async {
    final file = selectedPhoto.value;

    if (file == null) return null;

    return repository.uploadImage(file.path);
  }

  void _showLoadingDialog() {
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
  }

  void _closeLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future<void> _executeSave({
    required String currentImage,
    required Future<void> Function(String image) action,
    String successMessage = "Successfully",
  }) async {
    isSaving.value = true;

    _showLoadingDialog();

    try {
      final image = await uploadImage() ?? currentImage;

      await action(image);

      _closeLoadingDialog();

      AppFunction.flutterToast(msg: successMessage);

      Get.offAllNamed(RouteName.mainPage);
    } catch (e) {
      _closeLoadingDialog();

      AppFunction.flutterToast(msg: "Failed to save data: $e");

      debugPrint("Upload Error: $e");
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> saveProfile(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String image,
  ) async {
    final data = _extractFormData(formController);

    await _executeSave(
      currentImage: image,
      action: (uploadedImage) async {
        final profile = _buildProfileModel(
          controllers,
          data.mobiles,
          data.phones,
          data.emails,
          uploadedImage,
        );

        await firebaseUploadRepository.updateUserProfile(contact: profile);
      },
    );
  }

  Future<void> saveContact(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String image,
  ) async {
    final data = _extractFormData(formController);

    await _executeSave(
      currentImage: image,
      action: (uploadedImage) async {
        final contact = _buildContactModel(
          controllers,
          data.mobiles,
          data.phones,
          data.emails,
          uploadedImage,
          uid: Timestamp.now().millisecondsSinceEpoch.toString(),
        );

        await firebaseUploadRepository.postCard(contact: contact);
      },
    );
  }

  Future<void> updateCard(
    Map<String, TextEditingController> controllers,
    ContactFormController formController,
    String image,
    String uid,
  ) async {
    final data = _extractFormData(formController);

    await _executeSave(
      currentImage: image,
      successMessage: "Update Successfully",
      action: (uploadedImage) async {
        final contact = _updateContact(
          controllers,
          data.mobiles,
          data.phones,
          data.emails,
          uploadedImage,
          uid,
        );

        await firebaseUploadRepository.updateCard(contact: contact);
      },
    );
  }

  ({List<String> mobiles, List<String> phones, List<String> emails})
  _extractFormData(ContactFormController controller) {
    return (
      mobiles: controller.mobileControllers
          .map((e) => e.text.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      phones: controller.phoneControllers
          .map((e) => e.text.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      emails: controller.emailControllers
          .map((e) => e.text.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }

  ProfileModel _buildProfileModel(
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

  ContactModel _buildContactModel(
    Map<String, TextEditingController> controllers,
    List<String> mobiles,
    List<String> phones,
    List<String> emails,
    String image, {
    String? uid,
  }) {
    return ContactModel(
      uid: uid,
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

  ContactModel _updateContact(
    Map<String, TextEditingController> controllers,
    List<String> mobiles,
    List<String> phones,
    List<String> emails,
    String image,
    String uid,
  ) {
    return ContactModel(
      uid: uid,
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
