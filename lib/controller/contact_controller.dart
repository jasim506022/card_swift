
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../add_contract/example/model/contact.dart';
import '../add_contract/example/services/db_service.dart';

class ContactController extends GetxController {
  final RxList<Contact> contacts = <Contact>[].obs;
  final RxString query = ''.obs;
  final _uuid = const Uuid();

  @override
  void onInit() {
    super.onInit();
    load();
    ever(query, (_) => load());
  }

  Future<void> load() async {
    final list = await DbService.all(query: query.value);
    contacts.assignAll(list);
  }

  Future<void> addOrUpdate(Contact c) async {
    await DbService.upsert(c);
    await load();
  }

  Future<void> create({
    required String name,
    String? phone,
    String? email,
    String? company,
    String? notes,
    String? imagePath,
  }) async {
    final c = Contact(
      id: _uuid.v4(),
      name: name,
      phone: phone,
      email: email,
      company: company,
      notes: notes,
      imagePath: imagePath,
    );
    await DbService.upsert(c);
    await load();
  }

  Future<void> remove(String id) async {
    await DbService.delete(id);
    await load();
  }
}
