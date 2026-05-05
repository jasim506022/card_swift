import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:card_swift/model/contact_model.dart';
import 'package:card_swift/service/base_firebase_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUpload implements BaseFirebaseUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> updateUserProfile({required ContactModel contact}) async {
    String id = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    )!;
    await _firestore
        .collection("users")
        .doc(id)
        .set(contact.toMap(), SetOptions(merge: true));
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() async {
    String? uid = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    );
    return await _firestore.collection("users").doc(uid).get();
  }
}
