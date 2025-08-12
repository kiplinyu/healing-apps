import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/home_page.dart';
import 'package:healing_apps/apps/views/widgets/bottom_navbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const Center(child: Text("Calendar Page")),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Messages Page")),
    const Center(child: Text("Profile Page")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
