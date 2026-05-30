import 'dart:io';
import 'package:card_swift/controller/upload_controller.dart';
import 'package:card_swift/view/add_contact/add_contact.dart';
import 'package:card_swift/view/scan/review_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/business_card_model.dart';
import '../../controller/ocr_controller.dart';
import '../../model/contact_model.dart';

/*
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final OcrController ocr = Get.put(OcrController());
  final UploadController uploadController = Get.put(UploadController());

  BusinessCardModel? card;

  // File? imageFile;

  ContactModel? contactModel;

  // ================= PICK IMAGE =================
  /*
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(source: source);

    if (picked == null) return;

    final file = File(picked.path);

    setState(() {
      imageFile = file;
    });

    await ocr.scan(file);
  }


 */
  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Card')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _buildButtons(),

            const SizedBox(height: 16),

            _buildImage(),

            const SizedBox(height: 16),

            _buildLoading(),

            const SizedBox(height: 16),
            _buildResult(),
            ElevatedButton(
              onPressed: () {
                contactModel = ContactModel.convertCardToContact(card!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddContact(contactModel: contactModel!),
                  ),
                );
                Get.find<OcrController>().clearCardData();
              },
              child: Text("Review"),
            ),
            // _buildResult(),
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
            onPressed: () async {
              uploadController.pickImage(ImageSource.camera);
              await ocr.scan(uploadController.selectedPhoto.value!);
            },

            icon: const Icon(Icons.camera_alt),

            label: const Text("Camera"),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              uploadController.pickImage(ImageSource.gallery);
              await ocr.scan(uploadController.selectedPhoto.value!);
              card = ocr.card.value;
            },

            //pickImage(ImageSource.gallery),
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
      return Expanded(
        child: uploadController.selectedPhoto.value == null
            ? const Center(child: Text("No image selected"))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: Image.file(
                  uploadController.selectedPhoto.value!,
                  fit: BoxFit.contain,
                ),
              ),
      );
    });
  }

  // ================= LOADING =================

  Widget _buildLoading() {
    return Obx(() {
      return ocr.isLoading.value
          ? const LinearProgressIndicator()
          : const SizedBox.shrink();
    });
  }

  // ================= RESULT =================

  Widget _buildResult() {
    return Expanded(
      child: card == null
          ? const SizedBox.shrink()
          : ListView(
              children: [
                _tile("Name", card?.firstName),

                _tile("Position", card?.position),

                _tile("Company", card?.companyName),
                _tile("Department", card?.department),

                _tile("Emails", card?.emails.join(', ')),

                _tile("Phones", card?.phones.join(', ')),

                _tile("Websites", card?.websites),

                _tile("Address", card?.street),
              ],
            ),
    );
  }

  // ================= TILE =================

  Widget _tile(String title, String? value) {
    return Card(
      child: ListTile(title: Text(title), subtitle: Text(value ?? "Not found")),
    );
  }
}


 */



class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final OcrController ocr = Get.put(OcrController());
  final UploadController uploadController = Get.put(UploadController());

  ContactModel? contactModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildButtons(),
            const SizedBox(height: 16),
            _buildImage(),
            const SizedBox(height: 16),
            _buildLoading(),
            const SizedBox(height: 16),

            // Obx এর ভেতরে নেওয়া হয়েছে যাতে OCR স্ক্যান শেষ হলে রেজাল্ট অটোমেটিক স্ক্রিনে ভেসে ওঠে
            Obx(() {
              final currentCard = ocr.card.value;
              if (currentCard == null) return const SizedBox.shrink();

              return Expanded(
                child: ListView(
                  children: [
                    _tile("Name", currentCard.firstName),
                    _tile("Position", currentCard.position),
                    _tile("Company", currentCard.companyName),
                    _tile("Department", currentCard.department),
                    _tile("Emails", currentCard.emails.join(', ')),
                    _tile("Phones", currentCard.phones.join(', ')),
                    _tile("Websites", currentCard.websites),
                    _tile("Address", currentCard.street),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            // "Review" বাটনটি শুধু তখনই কাজ করবে যখন ডাটা থাকবে
            Obx(() {
              final currentCard = ocr.card.value;

              return ElevatedButton(
                onPressed: currentCard == null
                    ? null // ডাটা না থাকলে বা লোডিং চললে বাটনটি ডিজেবল (Grey) থাকবে
                    : () {
                  // Safe Conversion: এখানে আর ক্র্যাশ করার সুযোগ নেই
                  contactModel = ContactModel.convertCardToContact(currentCard);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddContact(contactModel: contactModel!),
                    ),
                  );

                  // ডাটা ক্লিয়ার করার লজিক
                  ocr.clearCardData();
                },
                child: const Text("Review"),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ================= BUTTONS (Fixing await & image null bug) =================
  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {

              await uploadController.pickImage(ImageSource.camera);


              if (uploadController.selectedPhoto.value != null) {
                await ocr.scan(uploadController.selectedPhoto.value!);
              }
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text("Camera"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {

              await uploadController.pickImage(ImageSource.gallery);


              if (uploadController.selectedPhoto.value != null) {
                await ocr.scan(uploadController.selectedPhoto.value!);
              }
            },
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
      return uploadController.selectedPhoto.value == null
          ? const Center(child: Text("No image selected"))
          : Container(
        height: 200, // লিস্টভিউ এর সাথে ঝামেলা এড়াতে ফিক্সড হাইট দেওয়া ভালো
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            uploadController.selectedPhoto.value!,
            fit: BoxFit.contain,
          ),
        ),
      );
    });
  }

  // ================= LOADING =================
  Widget _buildLoading() {
    return Obx(() {
      return ocr.isLoading.value
          ? const LinearProgressIndicator()
          : const SizedBox.shrink();
    });
  }

  // ================= TILE =================
  Widget _tile(String title, String? value) {
    return Card(
      child: ListTile(title: Text(title), subtitle: Text(value ?? "Not found")),
    );
  }
}