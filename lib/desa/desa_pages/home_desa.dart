import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/desa/desa_pages/usulan_page.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/desa_pages/dashboard_page.dart';

import 'package:loginapp/desa/desa_pages/user_page.dart';

class HomeDesa extends StatefulWidget {
  const HomeDesa({super.key});

  @override
  State<HomeDesa> createState() => _HomePageState();
}

class _HomePageState extends State<HomeDesa> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  int _selectedIndex = 1;
  bool isLoading = true;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    UsulanPage(),
    DashboardPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55,
        index: 1,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        letIndexChange: (index) => true,
        items: [
          Icon(
            Icons.menu,
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
