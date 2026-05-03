import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/contact_model.dart';
import '../controllers/ocr_controller.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import '../routes/app_routes.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

import '../services/ocr_service.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ocr = Get.put(OcrController());
  File? _imageFile;

  String scannedText = "";

  // File? scannedImage;

  Future<void> _pick(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Camera permission denied')),
          );
        }
        return;
      }
    }
    final picker = ImagePicker();
    final x = await picker.pickImage(source: source, imageQuality: 85);
    if (x == null) return;
    final file = File(x.path);
    setState(() => _imageFile = file);
    await ocr.run(file);
  }

  Future<void> scanDocument() async {
    try {
      final options = DocumentScannerOptions(
        mode: ScannerMode.full,
        pageLimit: 1,
      );

      final scanner = DocumentScanner(options: options);
      final result = await scanner.scanDocument();

      if (result != null && result.images!.isNotEmpty) {
        final filePath = result.images!.first;
        final file = File(filePath);

        final bytes = await file.readAsBytes();

        // Enhance image
        final enhancedBytes = await enhanceImage(bytes);
        final enhancedFile = await File(
          "${file.parent.path}/enhanced.jpg",
        ).writeAsBytes(enhancedBytes);

        setState(() {
          _imageFile = enhancedFile;
        });

        // 🔥 IMPORTANT FIX
        await ocr.run(enhancedFile); // not original file
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /*
  Future<void> scanDocument() async {
    try {
      // 1. Scan with ML Kit Document Scanner
      final options = DocumentScannerOptions(
        mode: ScannerMode.full,
        pageLimit: 1,
        isGalleryImportAllowed: true,
      );

      final scanner = DocumentScanner(options: options);
      final result = await scanner.scanDocument();

      if (result != null && result.images.isNotEmpty) {
        // ✅ v0.4.0 এ images.first ব্যবহার করতে হবে
        final filePath = result.images.first;
        final file = File(filePath);
        final bytes = await file.readAsBytes();

        // 2. Auto Resize & Enhance
        final enhancedBytes = await enhanceImage(bytes);
        final enhancedFile = await File("${file.parent.path}/enhanced.jpg")
            .writeAsBytes(enhancedBytes);

        setState(() {
          _imageFile = enhancedFile;

        });
        await ocr.run(file);

        /*
        // 3. OCR (Text Recognition)
        final textRecognizer = TextRecognizer();
        final inputImage = InputImage.fromFile(enhancedFile);
        final recognisedText = await textRecognizer.processImage(inputImage);

         */

        // setState(() async {
        //   scannedText = recognisedText.text;
        //   await ocr.run(file);
        //   Get.toNamed('/review', arguments: {
        //     'rawText': scannedText,
        //     'imagePath': enhancedFile.path,
        //   });
        // });


      }
    } catch (e) {
      print("Error: $e");
    }
  }
*/

  Future<Uint8List> enhanceImage(Uint8List bytes) async {
    final image = img.decodeImage(bytes)!;
    final resized = img.copyResize(image, width: 1024); // Auto resize
    final enhanced = img.adjustColor(resized);
    return Uint8List.fromList(img.encodeJpg(enhanced));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Card')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: scanDocument,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_imageFile != null)
              Expanded(child: Image.file(_imageFile!, fit: BoxFit.contain)),
            Obx(() {
              if (ocr.isProcessing.value) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: LinearProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),
            const SizedBox(height: 12),
            Obx(() {
              if (ocr.rawText.isEmpty) return const SizedBox.shrink();
              return ElevatedButton.icon(
                onPressed: () async {
                  // Console print
                  print("Row test");
                  print(ocr.rawText);

                  print("Parsed Fields Map:");

                  ocr.fields.forEach((key, value) {
                    print('$key: $value');
                  });

                  print(ocr.rawText);
                  print("Bangladesh");
                  final formattedList = ocr.fields.entries
                      .map((e) => "${e.key}: ${e.value}")
                      .toList();

                  print(formattedList);
                  print("Type of This: ${ocr.fields.runtimeType}");



                  var data = await MLKitService.extractEntityData(
                    ocr.rawText.value,
                  );



                  print(data.address);
                  print(data.emails);
                  print(data.phones);

                  var datas = await extractRemainingData(ocr.rawText.value, data.phones, data.emails, data.address);

                  print(datas.name);
                  print(datas.position);
                  print(datas.department);
                  print(datas.company);

                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Review & Save'),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Future<ContactModel> extractRemainingData(String rawText, List<String> extractedPhones, List<String> extractedEmails, String? extractedAddress) async {
  // ১. সম্পূর্ণ টেক্সটকে লাইনে ভাগ করা এবং বাড়তি স্পেস কমানো
  List<String> remainingLines = rawText.split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  // ২. ইমেইল, ফোন এবং অ্যাড্রেস ধারণ করা লাইনগুলো রিমুভ করা
  remainingLines.removeWhere((line) {
    bool containsPhone = extractedPhones.any((p) => line.contains(p));
    bool containsEmail = extractedEmails.any((e) => line.contains(e));
    bool containsAddress = extractedAddress != null && line.contains(extractedAddress);
    bool isWebsite = line.toLowerCase().contains('www.') || line.toLowerCase().contains('http');

    // ইমেইল বা ফোন লাইনে "Mobile:" বা "Email:" লেখা থাকলেও সেই লাইনটি বাদ যাবে
    return containsPhone || containsEmail || containsAddress || isWebsite;
  });

  // ৩. এখন remainingLines এ শুধু Name, Position, Department এবং Company আছে
  String? name, position, department, company;

  if (remainingLines.isNotEmpty) {
    // সাধারণত লোগোর ছোট টেক্সট (যেমন 'ecbl') এড়ানোর জন্য ৪ অক্ষরের বেশি লাইনকে নাম ধরছি
    name = remainingLines.firstWhere((l) => l.length > 3, orElse: () => remainingLines[0]);
    remainingLines.remove(name);
  }

  if (remainingLines.isNotEmpty) {
    // নামের ঠিক পরের লাইনটি সাধারণত পদবী (যেমন: Director)
    position = remainingLines[0];
    remainingLines.removeAt(0);
  }

  if (remainingLines.isNotEmpty) {
    // পদবীর নিচের লাইনটি সাধারণত ডিপার্টমেন্ট (যেমন: Marketing)
    department = remainingLines[0];
    remainingLines.removeAt(0);
  }

  // বাকি যা থাকবে তা কোম্পানি হিসেবে ধরা যেতে পারে
  if (remainingLines.isNotEmpty) {
    company = remainingLines.join(', ');
  }

  return ContactModel(
    name: name,
    position: position,
    department: department,
    company: company,
    phones: extractedPhones,
    emails: extractedEmails,
    address: extractedAddress,
  );
}


class MLKitService {
  // ভাষা হিসেবে ইংরেজি সেট করা (যেহেতু ভিজিটিং কার্ড সাধারণত ইংরেজিতে হয়)
  static final EntityExtractor _entityExtractor = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );

  static Future<ContactModel> extractEntityData(String text) async {
    final List<EntityAnnotation> annotations = await _entityExtractor
        .annotateText(text);

    List<String> foundPhones = [];
    List<String> foundEmails = [];
    String? address;
    String? name;

    for (final annotation in annotations) {
      for (final entity in annotation.entities) {
        // ফোন নম্বর চেক
        if (entity.type == EntityType.phone) {
          if (!foundPhones.contains(annotation.text)) {
            foundPhones.add(annotation.text);
          }
        }
        // ইমেইল অ্যাড্রেস চেক
        else if (entity.type == EntityType.email) {
          if (!foundEmails.contains(annotation.text)) {
            foundEmails.add(annotation.text);
          }
        }
        // ঠিকানা চেক
        else if (entity.type == EntityType.address) {
          address = annotation.text;
        }
      }
    }

    return ContactModel(
      phones: foundPhones,
      emails: foundEmails, // সব ইমেইল এখানে চলে আসবে
      address: address,
    );
  }

  // কাজ শেষ হলে মেমোরি খালি করা
  void dispose() {
    _entityExtractor.close();
  }
}

class ContactModel {
  final String? name;
  final String? position;
  final List<String> phones; // একাধিক ফোন নম্বর
  final List<String> emails; // একাধিক ইমেইল অ্যাড্রেস
  final String? address;
  final String? department;
  final String? company;

  ContactModel({
    this.name,
    required this.phones,
    required this.emails,
    this.address,
    this.position,
    this.department,
    this.company,
  });
}



// var data = ocr.rawText.value;
//
// Get.toNamed(
//   Routes.review,
//   arguments: {'fields': data, 'imagePath': _imageFile?.path},
// );

// try {
//   final aiData = await gemini.parseCard(ocr.rawText.value);
//
//   print("✅ SUCCESS:");
//   print(aiData);
//
// } catch (e) {
//   print("❌ ERROR:");
//   print(e);
//
//   Get.snackbar("Error", "AI parsing failed, using fallback");
//
//   /// 🔥 FALLBACK (VERY IMPORTANT)
//   // final fallback = ocr.parseFields(ocr.rawText.value);
//
//   print("🛟 FALLBACK DATA:");
//   // print(fallback);
// }