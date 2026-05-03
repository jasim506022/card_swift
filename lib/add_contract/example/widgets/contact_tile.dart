
import 'package:flutter/material.dart';
import '../model/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ContactTile({super.key, required this.contact, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(contact.name),
      subtitle: Text([contact.company, contact.phone, contact.email].where((e) => (e ?? '').isNotEmpty).join(' • ')),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
