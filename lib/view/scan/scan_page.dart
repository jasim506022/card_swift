import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/ocr_controller.dart';
import '../../controller/upload_controller.dart';
import '../../model/contact_model.dart';
import '../../route/route_name.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final OcrController ocr = Get.find<OcrController>();
  final UploadController uploadController = Get.find<UploadController>();

  ContactModel? contactModel;

  Future<void> _pickAndScan(ImageSource source) async {
    await uploadController.pickImage(source);

    final file = uploadController.selectedPhoto.value;
    if (file == null) return;

    await ocr.scan(file);
  }

  void _goToReview() {
    final card = ocr.card.value;
    if (card == null) return;

    contactModel = ContactModel.convertCardToContact(card);

    Get.toNamed(
      RouteName.addCard,
      arguments: {'contactModel': contactModel, 'isEdit': false},
    );
    ocr.clearCardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildButtons(),
            SizedBox(height: 16.h),
            _buildImage(),
            SizedBox(height: 16.h),
            _buildLoading(),
            SizedBox(height: 16.h),

            _buildResultList(),

            SizedBox(height: 16.h),

            _buildReviewButton(),
          ],
        ),
      ),
    );
  }

  // ================= BUTTONS =================
  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _pickAndScan(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: const Text("Camera"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _pickAndScan(ImageSource.gallery),
            icon: const Icon(Icons.photo),
            label: const Text("Gallery"),
          ),
        ),
      ],
    );
  }

  // ================= IMAGE =================
  Widget _buildImage() {
    return Obx(() {
      final file = uploadController.selectedPhoto.value;

      if (file == null) {
        return const Text("No image selected");
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          file,
          height: 200.h,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      );
    });
  }

  // ================= LOADING =================
  Widget _buildLoading() {
    return Obx(
      () => ocr.isLoading.value
          ? const LinearProgressIndicator()
          : const SizedBox.shrink(),
    );
  }

  // ================= OCR RESULT =================
  Widget _buildResultList() {
    return Obx(() {
      final card = ocr.card.value;
      if (card == null) return const SizedBox.shrink();

      return Expanded(
        child: ListView(
          children: [
            _tile("Name", card.firstName),
            _tile("Position", card.position),
            _tile("Company", card.companyName),
            _tile("Department", card.department),
            _tile("Emails", card.emails.join(', ')),
            _tile("Phones", card.phones.join(', ')),
            _tile("Websites", card.websites),
            _tile("Address", card.street),
          ],
        ),
      );
    });
  }

  // ================= REVIEW BUTTON =================
  Widget _buildReviewButton() {
    return Obx(() {
      final card = ocr.card.value;

      return ElevatedButton(
        onPressed: card == null ? null : _goToReview,
        child: const Text("Review"),
      );
    });
  }

  // ================= TILE =================
  Widget _tile(String title, String? value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value?.isNotEmpty == true ? value! : "Not found"),
      ),
    );
  }
}
