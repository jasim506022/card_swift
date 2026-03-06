import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:card_swift/add_contract/add_contact.dart';
import 'package:card_swift/main.dart';
import 'package:flutter/material.dart';

import '../view/profile_view.dart';

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

  final List<Widget> _screens = [
    ProfilePage(),
    Center(child: Text("Search Screen")),
    Center(child: Text("Settings Screen")),
    Center(child: Text("Profile Screen")),
  ];

  var _bottomNavIndex = 0; //default index of a first screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_bottomNavIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),

        //other params
      ),

      /*
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return Text("Bangladesh");
            },
          ),
          Text("Hello BAngladesh")
        ],
      ),


    */
    );
  }
}
