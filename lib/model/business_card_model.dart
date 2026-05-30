

class BusinessCardModel {
  final String? firstName; //
  final String? position; //
  final String? department; //
  final String? companyName; //
  final String? street;
  final String? websites;
  final String? image;

  final List<String> phones; //
  final List<String> emails; //


  const BusinessCardModel({
    this.firstName,
    this.position,
    this.department,
    this.companyName,
    this.image,
    this.street,
    this.phones = const [],
    this.emails = const [],
    this.websites
  });

  // ================= FROM MAP =================

  factory BusinessCardModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return BusinessCardModel(
      firstName: map['firstName'],
      position: map['position'],
      department: map['department'],
      companyName: map['companyName'],
      street: map['street'],
      image:  map['image'],

      phones: List<String>.from(
        map['phones'] ?? [],
      ),

      emails: List<String>.from(
        map['emails'] ?? [],
      ),

      websites:  map['websites'],
    );
  }

  // ================= TO MAP =================

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'position': position,
      'department': department,
      'companyName': companyName,
      'street': street,
      'phones': phones,
      'emails': emails,
      'websites': websites,
      'image':image
    };
  }

  // ================= COPY WITH =================

  BusinessCardModel copyWith({
    String? firstName,
    String? position,
    String? department,
    String? companyName,
    String? street,
    List<String>? phones,
    List<String>? emails,
    String?  websites,
  }) {
    return BusinessCardModel(
      firstName: firstName ?? this.firstName,
      position: position ?? this.position,
      department: department ?? this.department,
      companyName: companyName ?? this.companyName,
      street: street ?? this.street,
      phones: phones ?? this.phones,
      emails: emails ?? this.emails,
      websites: websites ?? this.websites,
    );
  }
}

/*
class BusinessCardModel {
  final String? firstName, position, department, companyName, street;
  final List<String> phones, emails, websites;

  BusinessCardModel({
    this.firstName,
    this.position,
    this.department,
    this.companyName,
    this.street,
    this.phones = const [],
    this.emails = const [],
    this.websites = const [],
  });

  BusinessCardModel copyWith({
    String? firstName,
    String? position,
    String? department,
    String? companyName,
    String? street,
    List<String>? phones,
    List<String>? emails,
    List<String>? websites,
  }) {
    return BusinessCardModel(
      firstName: firstName ?? this.firstName,
      position: position ?? this.position,
      department: department ?? this.department,
      companyName: companyName ?? this.companyName,
      street: street ?? this.street,
      phones: phones ?? this.phones,
      emails: emails ?? this.emails,
      websites: websites ?? this.websites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'position': position,
      'department': department,
      'companyName': companyName,
      'street': street,
      'phones': phones,
      'emails': emails,
      'websites': websites,
    };
  }
}


 */
/*
class BusinessCardModel {
  String? id;
  String? firstName;
  String? lastName;
  String? position;
  String? companyName;
  String? image; // Profile picture
  String? logo; // Company logo
  String? description; // Services offered
  String? department; // Services offered

  // একাধিক ডাটা হ্যান্ডেল করার জন্য List ব্যবহার করা ভালো
  List<String>? emails;
  List<String>? phones;
  List<String>? mobiles;

  List<String>? websites;

  // Social Media
  String? whatsapp;
  String? linkedin;
  String? facebook;

  // Address
  String? street;
  String? city;
  String? zipCode;
  String? country;

  BusinessCardModel({
    this.id,
    this.firstName,
    this.lastName,
    this.position,
    this.companyName,
    this.image,
    this.logo,
    this.description,
    this.emails,
    this.phones,
    this.websites,
    this.whatsapp,
    this.linkedin,
    this.facebook,
    this.street,
    this.city,
    this.zipCode,
    this.country,
    this.mobiles,
    this.department
  });

  // ফায়ারস্টোর থেকে ডাটা নেওয়ার জন্য (JSON to Model)
  factory BusinessCardModel.fromMap(Map<String, dynamic> map) {
    return BusinessCardModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      position: map['position'],
      companyName: map['companyName'],
      image: map['image'],
      department: map['department'],
      logo: map['logo'],
      description: map['description'],
      emails: map['emails'] != null ? List<String>.from(map['emails']) : [],
      phones: map['phones'] != null ? List<String>.from(map['phones']) : [],
      mobiles: map['mobiles'] != null ? List<String>.from(map['mobiles']) : [],
      websites: map['websites'] != null
          ? List<String>.from(map['websites'])
          : [],
      whatsapp: map['whatsapp'],
      linkedin: map['linkedin'],
      facebook: map['facebook'],
      street: map['street'],
      city: map['city'],
      zipCode: map['zipCode'],
      country: map['country'],
    );
  }

  // ফায়ারস্টোরে ডাটা সেভ করার জন্য (Model to JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'companyName': companyName,
      'image': image,
      'logo': logo,
      'description': description,
      'emails': emails,
      'phones': phones,
      'mobiles': mobiles,
      'websites': websites,
      'whatsapp': whatsapp,
      'linkedin': linkedin,
      'facebook': facebook,
      'department': department,
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'country': country,
    };
  }

  // ফুল নেম সহজে পাওয়ার জন্য একটি গেটার
  String get fullName => "${firstName ?? ''} ${lastName ?? ''}".trim();
}


 */
