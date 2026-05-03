import 'package:card_swift/common/style/apps_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/contact_model.dart';

class ContactFormController extends GetxController {
  var mobileControllers = <TextEditingController>[].obs;
  var phoneControllers = <TextEditingController>[].obs;
  var emailControllers = <TextEditingController>[].obs;

  void initData(ContactModel contact) {
    final map = contact.toMap();

    /// Clear old data first
    mobileControllers.clear();
    phoneControllers.clear();
    emailControllers.clear();

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

    update(); // 🔥 IMPORTANT
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
}
