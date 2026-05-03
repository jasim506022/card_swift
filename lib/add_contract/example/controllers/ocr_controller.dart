import 'dart:io';
import 'package:get/get.dart';
import '../services/ocr_service.dart';

class OcrController extends GetxController {
  final OcrService _ocr = OcrService();

  /// Raw OCR text
  final RxString rawText = ''.obs;

  /// Parsed fields as String (for UI)
  final RxMap<String, String?> fields = <String, String?>{}.obs;

  /// Loading state
  final RxBool isProcessing = false.obs;

  /// Run OCR on image and parse fields
  Future<void> run(File imageFile) async {
    isProcessing.value = true;
    try {
      final text = await _ocr.extractRawText(imageFile);
      rawText.value = text;

      final parsed = _ocr.parseFields(text);

      // Convert all values to String (Lists join with comma)
      fields.assignAll({
        'name': parsed['name'] as String?,
        'position': parsed['position'] as String?,
        'company': parsed['company'] as String?,
        'phones': (parsed['phones'] as List<String>?)?.join(', '),
        'emails': (parsed['emails'] as List<String>?)?.join(', '),
        'websites': (parsed['websites'] as List<String>?)?.join(', '),
        'address': parsed['address'] as String?,
      });

    } finally {
      isProcessing.value = false;
    }
  }

  @override
  void onClose() {
    _ocr.dispose();
    super.onClose();
  }
}
