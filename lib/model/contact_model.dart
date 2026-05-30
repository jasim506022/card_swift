import 'package:cloud_firestore/cloud_firestore.dart';

import 'business_card_model.dart';

class ContactModel {
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? jobTitle;
  final String? uid;
  final String? companyName;
  final String? description;
  final List<String>? mobileNumbers;
  final List<String>? phoneNumber;
  final List<String>? email;
  final String? website;
  final String? street;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? whatsapp;
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

  // এই ফাংশনটি দিয়ে আপনি কনভার্ট করবেন
  static ContactModel convertCardToContact(BusinessCardModel card) {
    String? first;
    String? last;
    String? zipCode;
    String? country;
    String? city;
    String? address;
    List<String> mobileNumbers = [];
    List<String> phoneNumbers = [];

    for (String rawNumber in card.phones) {
      // 1️⃣ Normalize the number for internal testing
      // Strips all spaces, hyphens, and parentheses: e.g. "(88 02) 4831" -> "88024831"
      String testNumber = rawNumber.replaceAll(RegExp(r'[\s\-()]'), '');

      if (testNumber.isEmpty) continue;

      // 2️⃣ Standardize bare '88' country codes so the checking prefixes align perfectly
      if (testNumber.startsWith('88')) {
        if (!testNumber.startsWith('880')) {
          // Direct patch for formatting cases like "88 02..." splitting anomalies
          testNumber = testNumber.replaceFirst('88', '880');
        }
        testNumber = '+' + testNumber; // Transforms "880..." into "+880..."
      }

      // 3️⃣ Sort using Regex matching rules

      // Mobile check: Matches '+8801...' or local '01...' formats
      final isMobile = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$').hasMatch(testNumber);

      // Landline check: Matches Dhaka prefixes starting with '+8802...' or '02...'
      final isLandline = RegExp(r'^(?:\+?88)?02\d{6,9}$').hasMatch(testNumber);

      if (isMobile) {
        mobileNumbers.add(
          rawNumber,
        ); // Retains original user formatting for visual design
      } else if (isLandline) {
        phoneNumbers.add(
          rawNumber,
        ); // Retains original user formatting for visual design
      }
    }

    if (card.firstName != null && card.firstName!.trim().isNotEmpty) {
      // নামের ভেতরের বাড়তি স্পেস রিমুভ করে লিস্টে ভাগ করা
      List<String> nameParts = card.firstName!.trim().split(RegExp(r'\s+'));

      if (nameParts.length == 1) {
        first = nameParts.first;
        last = ""; // যদি শুধু একটা নাম থাকে (যেমন: "Jasim")
      } else {
        first = nameParts.first; // প্রথম অংশ (যেমন: "Md")
        last = nameParts
            .sublist(1)
            .join(" "); // বাকি পুরো অংশ (যেমন: "Jasim Uddin")
      }
    }

    // ১. জিপ কোড বের করা (বিশ্বের বেশিরভাগ দেশের জিপ কোড ৩ থেকে ৮ ডিজিটের/অক্ষরের হয়)
    // এটি সংখ্যা এবং ইউকে/ইউএসএ ফরম্যাটের জিপ কোডও ধরবে
    final RegExp zipRegex = RegExp(
      r'\b\d{4,6}\b|\b[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}\b',
    );
    final zipMatch = zipRegex.firstMatch(card.street!);
    if (zipMatch != null) {
      zipCode = zipMatch.group(0)!;
    }

    // কমা দিয়ে আলাদা করা
    List<String> parts = card.street!.split(',').map((e) => e.trim()).toList();

    // পরিচিত কিছু দেশের তালিকা (প্রয়োজনে আরও যোগ করতে পারেন)
    List<String> knownCountries = [
      "USA",
      "UK",
      "CANADA",
      "UAE",
      "INDIA",
      "JAPAN",
      "MALAYSIA",
      "SINGAPORE",
      "BANGLADESH",
    ];

    if (parts.isNotEmpty) {
      String lastPart = parts.last;
      if (zipCode!.isNotEmpty) {
        lastPart = lastPart.replaceAll(zipCode, '').trim();
      }

      // ২. দেশ চেক করার স্মার্ট লজিক
      // যদি শেষ লেখাটি আমাদের পরিচিত দেশের তালিকায় থাকে অথবা লিস্টে অনেকগুলো পার্ট থাকে
      if (knownCountries.contains(lastPart.toUpperCase()) ||
          parts.length >= 3) {
        country = lastPart;
        parts.removeLast(); // দেশ ডিলিট
      } else {
        // যদি দেশের নাম না থাকে, তবে ধরে নেওয়া হবে এটিই শহর বা রাস্তা
        country = ""; // খালি থাকবে
      }
    }

    if (parts.isNotEmpty) {
      // ৩. শহর (City) বের করা
      String cityPart = parts.last;
      if (zipCode!.isNotEmpty) {
        cityPart = cityPart.replaceAll(zipCode, '').trim();
      }
      cityPart = cityPart.replaceAll(RegExp(r'[-\s]+$'), '').trim();

      city = cityPart;
      parts.removeLast(); // শহর ডিলিট
    }

    // ৪. বাকি অংশ স্ট্রিট
    if (parts.isNotEmpty) {
      address = parts.join(', ');
    } else {
      // যদি কমা না থাকে, পুরো টেক্সটটাই স্ট্রিট হিসেবে ব্যাকআপ থাকবে
      ;
    }

    print(mobileNumbers.length);

    return ContactModel(
      firstName: first,
      lastName: last,
      jobTitle: card.position,
      description: card.department,
      companyName: card.companyName,
      image: card.image,
      phoneNumber: phoneNumbers,
      mobileNumbers: mobileNumbers,
      email: card.emails,
      uid: "",
      createdAt: Timestamp.now(),
      city: city,
      country: country,
      facebook: "",
      street: address,
      website: card.websites!,
      whatsapp: "",
      zipCode: zipCode,
    );
  }

  /// 🔥 For easy print
  @override
  String toString() {
    return toMap().toString();
  }
}
