import 'package:flutter/material.dart';
import 'package:rlesports_app/pages/home.dart';
import 'package:rlesports_app/pages/news.dart';
import 'package:rlesports_app/pages/players_list.dart';
import 'package:rlesports_app/pages/team_list.dart';
import 'package:rlesports_app/theme/sizes.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/theme/colors.dart';

void main() {
  runApp(const RLEsports());
}

class RLEsports extends StatelessWidget {
  const RLEsports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class NavItem {
  final String label;
  final Icon icon;
  final Icon activeIcon;
  final Widget page;

  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<NavItem> navItems = const <NavItem>[
    NavItem(
      label: "Home",
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      page: HomePage(),
    ),
    NavItem(
      label: "News",
      icon: Icon(Icons.newspaper_outlined),
      activeIcon: Icon(Icons.newspaper),
      page: NewsPage(),
    ),
    NavItem(
      label: "Players",
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      page: PlayerList(),
    ),
    NavItem(
      label: "Teams",
      icon: Icon(Icons.people_outlined),
      activeIcon: Icon(Icons.people),
      page: TeamList(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> barItems = [];

    for (var navItem in navItems) {
      barItems.add(
        BottomNavigationBarItem(
          label: navItem.label,
          icon: navItem.icon,
          activeIcon: navItem.activeIcon,
        ),
      );
    }

    return Scaffold(
      appBar: const RLAppBar(),
      body: navItems[_selectedIndex].page,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.outlines,
              width: AppSizes.outlineWidth,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: barItems,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.matteGrey,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.navBarActiveIconBorder,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }
}
