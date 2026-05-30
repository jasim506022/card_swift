


/*
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _startScan,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                ),
              ],
            ),


             */

/*
            if (_imageFile != null)
              Expanded(child: Image.file(_imageFile!, fit: BoxFit.contain)),


             */

/*
            Obx(() {
              if (ocr.isProcessing.value) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: LinearProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            }),


             */

/*
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

                  var datas = await extractRemainingData(
                    ocr.rawText.value,
                    data.phones!,
                    data.emails!,
                    data.street,
                  );

                  print(datas.firstName);
                  print(datas.position);
                  print(datas.department);
                  print(datas.companyName);
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Review & Save'),
              );
            }),


 */


/*
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


   */


/*
Future<BusinessCardModel> extractRemainingData(
  String rawText,
  List<String> extractedPhones,
  List<String> extractedEmails,
  String? extractedAddress,
) async {
  // ১. সম্পূর্ণ টেক্সটকে লাইনে ভাগ করা এবং বাড়তি স্পেস কমানো
  List<String> remainingLines = rawText
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  // ২. ইমেইল, ফোন এবং অ্যাড্রেস ধারণ করা লাইনগুলো রিমুভ করা
  remainingLines.removeWhere((line) {
    bool containsPhone = extractedPhones.any((p) => line.contains(p));
    bool containsEmail = extractedEmails.any((e) => line.contains(e));
    bool containsAddress =
        extractedAddress != null && line.contains(extractedAddress);
    bool isWebsite =
        line.toLowerCase().contains('www.') ||
        line.toLowerCase().contains('http');

    // ইমেইল বা ফোন লাইনে "Mobile:" বা "Email:" লেখা থাকলেও সেই লাইনটি বাদ যাবে
    return containsPhone || containsEmail || containsAddress || isWebsite;
  });

  // ৩. এখন remainingLines এ শুধু Name, Position, Department এবং Company আছে
  String? name, position, department, company;

  if (remainingLines.isNotEmpty) {
    // সাধারণত লোগোর ছোট টেক্সট (যেমন 'ecbl') এড়ানোর জন্য ৪ অক্ষরের বেশি লাইনকে নাম ধরছি
    name = remainingLines.firstWhere(
      (l) => l.length > 3,
      orElse: () => remainingLines[0],
    );
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

  return BusinessCardModel(
    firstName: name,
    position: position,
    department: department,
    companyName: company,
    phones: extractedPhones,
    emails: extractedEmails,
    street: extractedAddress,
  );
}

class MLKitService {
  // ভাষা হিসেবে ইংরেজি সেট করা (যেহেতু ভিজিটিং কার্ড সাধারণত ইংরেজিতে হয়)
  static final EntityExtractor _entityExtractor = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );

  static Future<BusinessCardModel> extractEntityData(String text) async {
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

    return BusinessCardModel(
      phones: foundPhones,
      emails: foundEmails, // সব ইমেইল এখানে চলে আসবে
      street: address,
    );
  }

  // কাজ শেষ হলে মেমোরি খালি করা
  void dispose() {
    _entityExtractor.close();
  }
}


 */
/*
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


   */

/*
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


 */
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
