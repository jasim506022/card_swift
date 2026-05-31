import 'package:card_swift/common/style/app_string.dart';
import 'package:flutter/material.dart';

import '../view/holder/holder_view.dart';
import '../common/style/app_text_style.dart';
import '../view/home/home_view.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final Widget screen;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}

final List<BottomNavItem> navItems = [
  BottomNavItem(
    icon: Icons.home,
    label: AppString.home,
    screen: const HomePage(),
  ),
  BottomNavItem(
    icon: Icons.add_card_rounded,
    label: AppString.holder,
    screen: const HolderView(),
  ),
  BottomNavItem(
    icon: Icons.note_alt,
    label: AppString.notes,
    screen: Center(
      child: Text(AppString.notes, style: AppTextStyle.appBarTitle),
    ),
  ),
  BottomNavItem(
    icon: Icons.chat,
    label: AppString.chat,
    screen: Center(
      child: Text(AppString.chat, style: AppTextStyle.appBarTitle),
    ),
  ),
];
