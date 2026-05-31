import 'package:card_swift/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/contact_model.dart';

abstract class BaseFirebaseUpload {
  Future<void> updateUserProfile({required ProfileModel contact});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile();

  Future<void> postCard({required ContactModel contact});
  Future<void> updateCard({required ContactModel contact});

  Future<void> deleteCard({required String uid});

  Stream<List<Map<String, dynamic>>> getAllCardsStream();
}
