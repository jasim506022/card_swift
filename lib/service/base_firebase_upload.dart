import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/contact_model.dart';

abstract class BaseFirebaseUpload {
  Future<void> updateUserProfile({required ContactModel contact});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile();
}
