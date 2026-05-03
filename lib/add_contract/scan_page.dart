import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class CardScannerScreen extends StatefulWidget {
  const CardScannerScreen({super.key});

  @override
  State<CardScannerScreen> createState() => _CardScannerScreenState();
}

class _CardScannerScreenState extends State<CardScannerScreen> {
  final ImagePicker _picker = ImagePicker();

  String scannedText = "";

  // Controllers for form
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();

  /// 📷 Pick image from camera
  Future<void> pickAndScan() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final text = await scanText(image.path);

    setState(() {
      scannedText = text;
    });

    extractData(text);
  }

  /// 🧠 ML Kit text recognition
  Future<String> scanText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    return recognizedText.text;
  }

  /// 🔍 Extract data using regex
  void extractData(String text) {
    // Email
    final emailRegex = RegExp(r'\S+@\S+\.\S+');
    final email = emailRegex.firstMatch(text)?.group(0) ?? '';

    // Phone
    final phoneRegex = RegExp(r'\+?\d[\d\s-]{8,}');
    final phone = phoneRegex.firstMatch(text)?.group(0) ?? '';

    // Name (first line)
    final lines = text.split('\n');
    final name = lines.isNotEmpty ? lines[0] : '';

    // Company (simple guess)
    String company = '';
    for (var line in lines) {
      if (line.toLowerCase().contains('ltd') ||
          line.toLowerCase().contains('company') ||
          line.toLowerCase().contains('inc')) {
        company = line;
        break;
      }
    }

    setState(() {
      nameController.text = name;
      emailController.text = email;
      phoneController.text = phone;
      companyController.text = company;
    });
  }

  /// 🧾 UI Field
  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Card Scanner"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: pickAndScan,
                child: const Text("Scan Card"),
              ),

              const SizedBox(height: 20),

              /// 🧾 Auto-filled form
              buildField("Name", nameController),
              buildField("Email", emailController),
              buildField("Phone", phoneController),
              buildField("Company", companyController),

              const SizedBox(height: 20),

              /// 🔍 Raw text (optional)
              const Text(
                "Scanned Text:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(scannedText),
            ],
          ),
        ),
      ),
    );
  }
}