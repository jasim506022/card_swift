
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/contact_controller.dart';
import '../widgets/contact_tile.dart';
import '../routes/app_routes.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name, company, phone, email...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => controller.query.value = v,
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.contacts;
              if (items.isEmpty) {
                return const Center(child: Text('No contacts yet. Tap + to add or scan a card.'));
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  final c = items[i];
                  return ContactTile(
                    contact: c,
                    onTap: () => Get.toNamed(Routes.contactForm, arguments: c),
                    onDelete: () => controller.remove(c.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'scan',
            onPressed: () => Get.toNamed(Routes.scan),
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Scan'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'add',
            onPressed: () => Get.toNamed(Routes.contactForm),
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
