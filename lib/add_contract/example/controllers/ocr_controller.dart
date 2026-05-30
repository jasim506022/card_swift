import 'dart:io';
import 'package:get/get.dart';

import '../../../model/business_card_model.dart';
import '../../../service/card_parse_service.dart';

class OcrController extends GetxController {
  final BusinessCardService _service = BusinessCardService();


  final RxBool isLoading = false.obs;

  final Rx<BusinessCardModel?> card = Rx<BusinessCardModel?>(null);

  Future<void> scan(File image) async {
    isLoading.value = true;

    try {
      final result = await _service.scanCard(image);

      card.value = result;
    } finally {
      isLoading.value = false;
    }
  }

  void clearCardData() {
    card.value = null;
  }

  @override
  void onClose() {
    _service.dispose();
    super.onClose();
  }
}
