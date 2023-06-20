import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/dinkes/dinkes_pages/dashboard_dinkes_page.dart';
import 'package:loginapp/dinkes/dinkes_pages/data_dinkes_page.dart';
import 'package:loginapp/dinkes/dinkes_pages/user_dinkes_page.dart';
import 'package:loginapp/dinkes/dinkes_pages/usulan_desa_dinkes.dart';
import 'package:loginapp/dinkes/dinkes_pages/usulan_dinkes_page.dart';
import 'package:loginapp/shared/colors.dart';

class HomeDinkes extends StatefulWidget {
  const HomeDinkes({super.key});

  @override
  State<HomeDinkes> createState() => _HomeDinkesState();
}

class _HomeDinkesState extends State<HomeDinkes> {
  int _selectedIndex = 2;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    DataDinkesPage(),
    UsulanDinkesPage(),
    DashboardDinkesPage(),
    UsulanDesaDinkesPage(),
    UserDinkesPage(),
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
            Icons.bar_chart_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.checklist_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.list_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.person_rounded,
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
