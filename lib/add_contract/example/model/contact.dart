
import 'dart:convert';

class Contact {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? company;
  final String? notes;
  final String? imagePath;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.company,
    this.notes,
    this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? company,
    String? notes,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      company: company ?? this.company,
      notes: notes ?? this.notes,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'company': company,
      'notes': notes,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      company: map['company'] as String?,
      notes: map['notes'] as String?,
      imagePath: map['imagePath'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source) as Map<String, dynamic>);
}
