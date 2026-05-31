import 'package:card_swift/common/style/app_string.dart';
import 'package:card_swift/common/style/apps_constant.dart';
import 'package:card_swift/model/contact_model.dart';
import 'package:card_swift/model/profile_model.dart';
import 'package:card_swift/service/base_firebase_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUpload implements BaseFirebaseUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> updateUserProfile({required ProfileModel contact}) async {
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

  @override
  Future<void> postCard({required ContactModel contact}) async {
    String? uid = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    );
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("card")
        .doc(contact.uid)
        .set(contact.toMap());
  }

  @override
  Future<void> deleteCard({required String uid}) async {
    String? userUid = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    );
    print(userUid);
    print(uid);
    await _firestore
        .collection("users")
        .doc(userUid)
        .collection("card")
        .doc(uid)
        .delete();
  }

  @override
  Stream<List<Map<String, dynamic>>> getAllCardsStream() {
    String? uid = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    );
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("card")
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  @override
  Future<void> updateCard({required ContactModel contact}) async {
    print("Bangadesh is");
    String? uid = AppsConstant.sharedPreferences!.getString(
      AppString.uidSharedPreference,
    );

    print("Bangladesh ${contact.uid!}Bangladesh");

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("card")
        .doc(
          contact.uid!,
        ) // <-- Double-check that this ID matches the existing Firestore document ID
        .update(contact.toMap());
  }
}
