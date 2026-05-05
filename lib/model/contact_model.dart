import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String? uid;
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? jobTitle;
  final String? companyName;
  final String? description;
  final List<String>? mobileNumbers;
  final List<String>? phoneNumber;
  final List<String>? email;
  final String? street;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? whatsapp;
  final String? website;
  final String? facebook;
  final Timestamp? createdAt;

  ContactModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.jobTitle,
    this.companyName,
    this.description,
    this.mobileNumbers,
    this.phoneNumber,
    this.email,

    this.street,
    this.city,
    this.zipCode,
    this.country,
    this.whatsapp,
    this.website,
    this.facebook,
    this.image,
    this.createdAt,
  });

  /// 🔥 Convert to Map (for API / Firebase)
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "uid": uid,
      "lastName": lastName,
      "jobTitle": jobTitle,
      "companyName": companyName,
      "description": description,
      "mobileNumbers": mobileNumbers,
      "phoneNumber": phoneNumber,
      "email": email,
      "street": street,
      "city": city,
      "zipCode": zipCode,
      "country": country,
      "whatsapp": whatsapp,
      "website": website,
      "facebook": facebook,
      "image": image,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  /// 🔥 Convert Firebase/Map to ContactModel
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      image: map['image'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      jobTitle: map['jobTitle'],
      companyName: map['companyName'],
      description: map['description'],
      // Ensure lists are cast correctly from dynamic Firestore arrays
      mobileNumbers: List<String>.from(map['mobileNumbers'] ?? []),
      phoneNumber: List<String>.from(map['phoneNumber'] ?? []),
      email: List<String>.from(map['email'] ?? []),
      street: map['street'],
      city: map['city'],
      zipCode: map['zipCode'],
      country: map['country'],
      whatsapp: map['whatsapp'],
      website: map['website'],
      facebook: map['facebook'],
      createdAt: map['createdAt'],
      uid: map['uid'],
    );
  }

  /// 🔥 For easy print
  @override
  String toString() {
    return toMap().toString();
  }
}
