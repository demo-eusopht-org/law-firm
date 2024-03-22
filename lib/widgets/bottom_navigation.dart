import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/home/home_screen.dart';
import 'package:case_management/view/profile/settings.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../view/cases/assigned_cases.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    screens = [
      HomeScreen(),
      AssignedCases(
        userId: int.parse(locator<LocalStorageService>().getData('id')!),
        // Since user is currently signed in user, the condition in
        // AssignedCases will make this property useless, hence the empty
        // string.
        userDisplayName: '',
      ),
      Settings(),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.green,
        items: [
          TabItem(
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.black,
              size: 35,
            ),
          ),
          TabItem(
            icon: Icon(
              Icons.cases_outlined,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.cases_outlined,
              color: Colors.black,
              size: 35,
            ),
          ),
          TabItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
        onTap: _onItemTapped,
        initialActiveIndex: _selectedIndex,
      ),
      body: screens[_selectedIndex],
    );
  }
}
