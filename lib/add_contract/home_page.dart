import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:card_swift/add_contract/add_contact.dart';
import 'package:card_swift/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/profile/profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  final labels = ["Home", "Search", "Settings", "Profile"];

  final List<Widget> _screens = [
    ProfilePage(),
    Center(child: Text("Search Screen")),
    Center(child: Text("Settings Screen")),
    Center(child: Text("Profile Screen")),
  ];

  var _bottomNavIndex = 0; //default index of a first screen

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: _screens[_bottomNavIndex],

      floatingActionButton: FloatingActionButton(
        elevation: 4,
        // Adds a shadow so it stands out
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(Icons.camera_alt, size: 40.h, color: Colors.grey),
        onPressed: () => print("Camera Opened"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300, // Color of the line
              width: 1.0,                 // Thickness of the line
            ),
          ),
        ),
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.blue : Colors.grey;
            final labels = ["Home", "Search", "Settings", "Profile"];

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
