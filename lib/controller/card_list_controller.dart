import 'package:get/get.dart';

import '../common/style/app_function.dart';
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
    listenToAllCards();
  }

  void listenToAllCards() {
    isListLoading.value = true;

    firebaseUploadRepository.getAllCardsStream().listen(
      (snapshotData) {
        allCards.value = snapshotData.map((map) {
          return ContactModel.fromMap(map);
        }).toList();

        isListLoading.value = false;
      },
      onError: (error) {
        isListLoading.value = false;
        Get.snackbar("Error", "Failed to fetch cards: $error");
      },
    );
  }

  Future<void> deleteCard({required String uid}) async {
    try {
      // Use await so the code waits for Firestore to finish deleting
      await firebaseUploadRepository.deleteCard(uid: uid);

      // Show success toast feedback to the user
      AppFunction.flutterToast(msg: "Card deleted successfully");
    } catch (error) {
      print("Delete Error: $error");
      Get.snackbar("Error", "Failed to delete card: $error");
    }
  }
}
