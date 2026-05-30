import 'package:get/get.dart';

import '../model/contact_model.dart';
import '../repository/firebase_upload_repository.dart';

class CardListController extends GetxController {
  final FirebaseUploadRepository firebaseUploadRepository =
      FirebaseUploadRepository();


  final RxList<ContactModel> allCards = <ContactModel>[].obs;
  final RxBool isListLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    listenToAllCards(); // কন্ট্রোলার মেমোরিতে আসলেই ডাটা লোড শুরু হবে
  }

  // রিয়েল-টাইম ডাটা লিসেন করার মেথড
  void listenToAllCards() {
    isListLoading.value = true;

    firebaseUploadRepository.getAllCardsStream().listen(
      (snapshotData) {
        // ম্যাপ লিস্টকে অবজেক্ট (Model) লিস্টে কনভার্ট করা
        allCards.value = snapshotData.map((map) {
          return ContactModel.fromMap(
            map,
          ); // আপনার মডেলের fromMap/fromJson মেথড
        }).toList();

        isListLoading.value = false;
      },
      onError: (error) {
        isListLoading.value = false;
        Get.snackbar("Error", "Failed to fetch cards: $error");
      },
    );
  }
}
