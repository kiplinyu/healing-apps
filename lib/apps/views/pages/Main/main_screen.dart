import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Main/favorites/favorite_page.dart';
import 'package:healing_apps/apps/views/pages/Main/home/home_page.dart';
import 'package:healing_apps/apps/views/pages/Main/profile/profile_page.dart';
import 'package:healing_apps/apps/views/pages/Main/schedule/schedule_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The main screen of the app that contains the BottomNavigationBar.
///
/// This widget acts as a shell, holding the different pages (Home, Schedule, etc.)
/// and allowing the user to switch between them. The BottomNavigationBar remains
/// persistent while the body content changes.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar semua halaman yang akan ditampilkan
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SchedulePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed, // Agar semua item terlihat
        selectedItemColor: const Color(0xFF0059B8),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.house),
            activeIcon: Icon(PhosphorIconsFill.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.calendarBlank),
            activeIcon: Icon(PhosphorIconsFill.calendarBlank),
            label: 'My Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.heart),
            activeIcon: Icon(PhosphorIconsFill.heart),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.user),
            activeIcon: Icon(PhosphorIconsFill.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'This is the $title Screen',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
