import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:card_swift/route/route_name.dart';
import 'package:card_swift/add_contract/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../profile/profile_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final iconList = <IconData>[
    Icons.home,
    Icons.add_card_rounded,
    Icons.note_alt,
    Icons.chat,
  ];

  final List<Widget> _screens = [
    ProfilePage(),
    HomeViewPage(),
    Center(child: Text("Profile Screen")),
    Center(child: Text("Profile Screen")),
  ];

  var _bottomNavIndex = 0; //default index of a first screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_bottomNavIndex],

      floatingActionButton: FloatingActionButton(
        elevation: 4,
        // Adds a shadow so it stands out
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(Icons.camera_alt, size: 40.h, color: Colors.grey),
        onPressed: () => Get.toNamed(RouteName.scanPage),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300, // Color of the line
              width: 1.0, // Thickness of the line
            ),
          ),
        ),
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.blue : Colors.grey;
            final labels = ["Home", "Holder", "Notes", "Chat"];

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconList[index], size: 24.h, color: color),
                SizedBox(height: 2.h), // Small gap between icon and text
                Text(
                  labels[index],
                  style: TextStyle(
                    color: color,
                    fontSize: 10.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          },
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          // Optional: Adjust the height to accommodate the text
          height: 70.h,
        ),
      ),
    );
  }
}
