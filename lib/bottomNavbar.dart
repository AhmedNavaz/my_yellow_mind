import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/cbt/screens/cbtHome.dart';
import 'package:my_yellow_mind/modules/meditation/screens/mindfulnessHome.dart';
import 'package:my_yellow_mind/modules/sleep/screens/sleepHome.dart';

import 'modules/settings/screens/settingsHome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset(
                  'assets/icons/meditation_inactive.svg',
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/meditation_active.svg'),
              ),
              label: 'Meditation',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/cbt_inactive.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/cbt_active.svg'),
              ),
              label: 'CBT',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/sleep_active.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/sleep_active.svg'),
              ),
              label: 'Sleep',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/settings_inactive.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/icons/settings_active.svg'),
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff3B5CFF),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          selectedLabelStyle: customTextStyle(12, FontWeight.w500),
          unselectedLabelStyle: customTextStyle(12, FontWeight.w500),
          onTap: _onItemTapped,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          MindfulnessHomeScreen(),
          CBTHomeScreen(),
          SleepHomeScreen(),
          SettingsHomeScreen(),
        ],
      ),
    );
  }
}
