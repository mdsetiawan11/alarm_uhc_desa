import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/dinsos/dinsos_pages/dashboard_dinsos_page.dart';
import 'package:loginapp/dinsos/dinsos_pages/data_dinsos_page.dart';
import 'package:loginapp/dinsos/dinsos_pages/user_dinsos_page.dart';
import 'package:loginapp/dinsos/dinsos_pages/usulan_dinsos_page.dart';

import 'package:loginapp/shared/colors.dart';

class HomeDinsos extends StatefulWidget {
  const HomeDinsos({super.key});

  @override
  State<HomeDinsos> createState() => _HomeDinsosState();
}

class _HomeDinsosState extends State<HomeDinsos> {
  int _selectedIndex = 2;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    DataDinsosPage(),
    UsulanDinsosPage(),
    DashboardDinsosPage(),
    UserDinsosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55,
        index: 2,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        letIndexChange: (index) => true,
        items: [
          Icon(
            Icons.checklist_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.grey.shade50,
        color: Palette.mainColor,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
