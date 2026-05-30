import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/style/app_colors.dart';
import '../../controller/auth_controller.dart';
import '../../model/bottom_nav_item.dart';
import '../../route/route_name.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final AuthController _authController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  void _onTabChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = navItems[_currentIndex];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          _authController.confirmExitApp(),
      child: Scaffold(
        body: currentItem.screen,

        floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: AppColors.white,
          shape: const CircleBorder(),
          onPressed: () => Get.toNamed(RouteName.scanPage),
          child: Icon(Icons.camera_alt, size: 40.h, color: AppColors.grey),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: AnimatedBottomNavigationBar.builder(
        itemCount: navItems.length,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        height: 70.h,
        onTap: _onTabChanged,

        tabBuilder: (index, isActive) {
          final item = navItems[index];
          final color = isActive ? Colors.blue : Colors.grey;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 24.h, color: color),
              SizedBox(height: 2.h),
              Text(
                item.label,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 12.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
