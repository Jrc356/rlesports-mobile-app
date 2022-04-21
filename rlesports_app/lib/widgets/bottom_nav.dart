import 'package:flutter/material.dart';
import 'package:rlesports_app/assets/colors.dart';

import '../assets/sizes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: AppColors.outlines,
            width: AppSizes.outlineWidth,
          ),
        )),
        child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "News",
                icon: Icon(Icons.newspaper_outlined),
                activeIcon: Icon(Icons.newspaper),
              ),
              BottomNavigationBarItem(
                label: "Players",
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                label: "Teams",
                icon: Icon(Icons.people_outlined),
                activeIcon: Icon(Icons.people),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.matteGrey,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.navBarActiveIconBorder,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5));
  }
}
