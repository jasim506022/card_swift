
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/contact_controller.dart';
import '../model/contact.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final ContactController controller = Get.find<ContactController>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController company;
  late final TextEditingController notes;

  Contact? editing;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map? ?? {};
    if (args['prefill'] != null) {
      final Map p = args['prefill'];
      name = TextEditingController(text: (p['name'] ?? '').toString());
      phone = TextEditingController(text: (p['phone'] ?? '').toString());
      email = TextEditingController(text: (p['email'] ?? '').toString());
      company = TextEditingController(text: (p['company'] ?? '').toString());
      notes = TextEditingController(text: (p['notes'] ?? '').toString());
      imagePath = p['imagePath'] as String?;
    } else if (args is Contact) {
      editing = args as Contact?;
      name = TextEditingController(text: editing!.name);
      phone = TextEditingController(text: editing!.phone ?? '');
      email = TextEditingController(text: editing!.email ?? '');
      company = TextEditingController(text: editing!.company ?? '');
      notes = TextEditingController(text: editing!.notes ?? '');
      imagePath = editing!.imagePath;
    } else {
      name = TextEditingController();
      phone = TextEditingController();
      email = TextEditingController();
      company = TextEditingController();
      notes = TextEditingController();
    }
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    company.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() != true) return;
    if (editing != null) {
      final updated = editing!.copyWith(
        name: name.text.trim(),
        phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
        email: email.text.trim().isEmpty ? null : email.text.trim(),
        company: company.text.trim().isEmpty ? null : company.text.trim(),
        notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
        imagePath: imagePath,
      );
      await controller.addOrUpdate(updated);
    } else {
      await controller.create(
        name: name.text.trim(),
        phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
        email: email.text.trim().isEmpty ? null : email.text.trim(),
        company: company.text.trim().isEmpty ? null : company.text.trim(),
        notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
        imagePath: imagePath,
      );
    }
    if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editing != null ? 'Edit Contact' : 'Save Contact')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name *'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 12),
            TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextFormField(controller: company, decoration: const InputDecoration(labelText: 'Company')),
            const SizedBox(height: 12),
            TextFormField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
