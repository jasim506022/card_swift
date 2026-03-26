import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widget/custom_app_bar.dart';

/// A reusable layout for authentication screens (login, signup, etc.).
/// It provides a scaffold with a custom app bar and scrollable body.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.title,
    required this.children,
    this.showBackButton = true, this.onBackPressed,
  });

  final String title;

  /// List of widgets to display in the body
  final List<Widget> children;

  /// Whether to show the back button in the AppBar
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Custom AppBar widget
      appBar: CustomAppBar(title: title, showBackButton: showBackButton, onBackPressed: onBackPressed,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
