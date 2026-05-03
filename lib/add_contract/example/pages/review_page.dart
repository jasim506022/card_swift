
/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController company;
  late final TextEditingController notes;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map? ?? {};
    final Map fields = (args['fields'] as Map?) ?? {};
    imagePath = args['imagePath'] as String?;
    name = TextEditingController(text: (fields['name'] ?? '').toString());
    phone = TextEditingController(text: (fields['phone'] ?? '').toString());
    email = TextEditingController(text: (fields['email'] ?? '').toString());
    company = TextEditingController(text: (fields['company'] ?? '').toString());
    notes = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Extracted Data')),
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
              onPressed: () {
                if (_formKey.currentState?.validate() != true) return;
                Get.toNamed(Routes.contactForm, arguments: {
                  'prefill': {
                    'name': name.text.trim(),
                    'phone': phone.text.trim(),
                    'email': email.text.trim(),
                    'company': company.text.trim(),
                    'notes': notes.text.trim(),
                    'imagePath': imagePath,
                  }
                });
              },
              icon: const Icon(Icons.save_alt),
              label: const Text('Continue to Save'),
            )
          ],
        ),
      ),
    );
  }
}


*/



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController company;
  late final TextEditingController notes;

  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> emailControllers = [];

  String? imagePath;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map? ?? {};
    print("Arguments received: $args"); // Debug

    var  fields = (args['fields'] );
    print("Extracted fields: $fields");


    imagePath = args['imagePath'] as String?;

    name = TextEditingController(text: "(fields['name'] ?? '').toString()");
    company = TextEditingController(text: "(fields['company'] ?? '').toString()");
    notes = TextEditingController();

    // ✅ Initialize phone & email controllers from fields
    List phones =  [];
    List emails =  [];

    phoneControllers = [];
    emailControllers = [];

    if (phoneControllers.isEmpty) phoneControllers.add(TextEditingController());
    if (emailControllers.isEmpty) emailControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    name.dispose();
    company.dispose();
    notes.dispose();
    for (var c in phoneControllers) c.dispose();
    for (var c in emailControllers) c.dispose();
    super.dispose();
  }

  void addPhoneField() {
    setState(() => phoneControllers.add(TextEditingController()));
  }

  void addEmailField() {
    setState(() => emailControllers.add(TextEditingController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Extracted Data')),
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

            // ✅ Dynamic Phone Fields
            const Text('Phone Numbers'),
            ...phoneControllers.asMap().entries.map((entry) {
              int index = entry.key;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: entry.value,
                        decoration: InputDecoration(labelText: 'Phone ${index + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        if (phoneControllers.length > 1) {
                          setState(() => phoneControllers.removeAt(index));
                        }
                      },
                    )
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: addPhoneField,
              icon: const Icon(Icons.add),
              label: const Text('Add Phone'),
            ),
            const SizedBox(height: 12),

            // ✅ Dynamic Email Fields
            const Text('Emails'),
            ...emailControllers.asMap().entries.map((entry) {
              int index = entry.key;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: entry.value,
                        decoration: InputDecoration(labelText: 'Email ${index + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        if (emailControllers.length > 1) {
                          setState(() => emailControllers.removeAt(index));
                        }
                      },
                    )
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: addEmailField,
              icon: const Icon(Icons.add),
              label: const Text('Add Email'),
            ),
            const SizedBox(height: 12),

            TextFormField(controller: company, decoration: const InputDecoration(labelText: 'Company')),
            const SizedBox(height: 12),
            TextFormField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState?.validate() != true) return;

                final phones = phoneControllers.map((c) => c.text.trim()).where((v) => v.isNotEmpty).toList();
                final emails = emailControllers.map((c) => c.text.trim()).where((v) => v.isNotEmpty).toList();

                Get.toNamed(Routes.contactForm, arguments: {
                  'prefill': {
                    'name': name.text.trim(),
                    'phones': phones,
                    'emails': emails,
                    'company': company.text.trim(),
                    'notes': notes.text.trim(),
                    'imagePath': imagePath,
                  }
                });
              },
              icon: const Icon(Icons.save_alt),
              label: const Text('Continue to Save'),
            )
          ],
        ),
      ),
    );
  }
}


