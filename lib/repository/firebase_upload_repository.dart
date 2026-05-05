import 'package:card_swift/service/firebase_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/contact_model.dart';

class FirebaseUploadRepository {
  FirebaseUpload firebaseUpload = FirebaseUpload();

  Future<void> updateUserProfile({required ContactModel contact}) async {
    await firebaseUpload.updateUserProfile(contact: contact);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() async {
    return firebaseUpload.getUserProfile();
  }
}
