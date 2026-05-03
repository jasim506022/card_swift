import 'package:cloud_firestore/cloud_firestore.dart';

/*
class UserModel {
  String? name;
  String? email;
  String? uid;
  String? photoUrl;
  String? designation;
  String? phoneNumber;
  Timestamp? createdAt;

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.photoUrl,
    this.designation,
    this.phoneNumber,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'designation': designation,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
      designation: map['designation'] as String,
      phoneNumber: map['phoneNumber'] as String,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
    String? designation,
    String? phoneNumber,
    Timestamp? createdAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      designation: designation ?? this.designation,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}


 */