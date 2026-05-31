import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final Color color;
  final String title;

  MenuItem({required this.icon, required this.color, required this.title});
}

final List<MenuItem> menuItems = [
  MenuItem(icon: Icons.group, color: Colors.blue, title: "Groups (1)"),
  MenuItem(
    icon: Icons.person_add_alt_1,
    color: Colors.orange,
    title: "Add Contact",
  ),
  MenuItem(icon: Icons.handshake, color: Colors.red, title: "Team"),
  MenuItem(icon: Icons.open_in_new, color: Colors.pink, title: "Export"),
  MenuItem(icon: Icons.arrow_upward, color: Colors.blue, title: "Import"),
  MenuItem(icon: Icons.dashboard, color: Colors.green, title: "CRM"),
];
