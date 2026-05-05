import 'package:card_swift/common/style/apps_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/contact_model.dart';

class ContactFormController extends GetxController {
  final mobileControllers = <TextEditingController>[].obs;
  final phoneControllers = <TextEditingController>[].obs;
  final emailControllers = <TextEditingController>[].obs;

  /// 🔹 Init ALL data (text + list)
  void initData(
    ContactModel contact,
    Map<String, TextEditingController> controllers,
  ) {
    final map = contact.toMap();

    /*
    /// Clear old data first
    mobileControllers.clear();
    phoneControllers.clear();
    emailControllers.clear();


     */

    /// 1️⃣ Clear old list data
    _clearLists();

    /*
    /// Fill data
    for (var entry in AppsConstant.modelKeyMap.entries) {
      final key = entry.value;
      final value = map[key];

      if (value == null) continue;

      if (value is List) {
        for (var item in value) {
          if (item.toString().trim().isEmpty) continue;
          _add(entry.key, item.toString());
        }
      }
    }


     */

    /// 2️⃣ Fill TEXT fields
    _fillTextFields(map, controllers);

    /*
    /// ensure at least one field
    if (mobileControllers.isEmpty) {
      mobileControllers.add(TextEditingController());
    }
    if (phoneControllers.isEmpty) {
      phoneControllers.add(TextEditingController());
    }
    if (emailControllers.isEmpty) {
      emailControllers.add(TextEditingController());
    }

     */

    /// 3️⃣ Fill LIST fields
    _fillListFields(map);

    /// 4️⃣ Ensure at least one input exists
    _ensureAtLeastOne();

    update(); // 🔥 IMPORTANT
  }

  // ================= LIST =================
  void _fillListFields(Map<String, dynamic> map) {
    for (var entry in AppsConstant.modelKeyMap.entries) {
      final key = entry.value;
      final value = map[key];

      if (value is List) {
        for (var item in value) {
          final text = item.toString().trim();
          if (text.isNotEmpty) {
            _add(entry.key, text);
          }
        }
      }
    }
  }

  void _ensureAtLeastOne() {
    if (mobileControllers.isEmpty) addMobile();
    if (phoneControllers.isEmpty) addPhone();
    if (emailControllers.isEmpty) addEmail();
  }

  /// ================= ADD =================
  void addMobile() => mobileControllers.add(TextEditingController());

  void addPhone() => phoneControllers.add(TextEditingController());

  void addEmail() => emailControllers.add(TextEditingController());

  /// ================= REMOVE =================
  void removeMobile(int i) {
    mobileControllers[i].dispose();
    mobileControllers.removeAt(i);
  }

  void removePhone(int i) {
    phoneControllers[i].dispose();
    phoneControllers.removeAt(i);
  }

  void removeEmail(int i) {
    emailControllers[i].dispose();
    emailControllers.removeAt(i);
  }

  void _add(String type, String value) {
    if (type == "Mobile Number") {
      mobileControllers.add(TextEditingController()..text = value);
    } else if (type == "Phone Number") {
      phoneControllers.add(TextEditingController()..text = value);
    } else if (type == "Email Address") {
      emailControllers.add(TextEditingController()..text = value);
    }
  }

  // ================= TEXT =================
  void _fillTextFields(
    Map<String, dynamic> map,
    Map<String, TextEditingController> controllers,
  ) {
    for (var entry in AppsConstant.modelKeyMap.entries) {
      final key = entry.value;
      final value = map[key];

      if (value is String && controllers.containsKey(entry.key)) {
        controllers[entry.key]!.text = value;
      }
    }
  }

  void _clearLists() {
    for (var c in [
      ...mobileControllers,
      ...phoneControllers,
      ...emailControllers,
    ]) {
      c.dispose();
    }
    mobileControllers.clear();
    phoneControllers.clear();
    emailControllers.clear();
  }
}
