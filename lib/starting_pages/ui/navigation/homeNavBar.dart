import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseLink.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/intro_page1.dart';
import 'package:morflutter/starting_pages/ui/profile/UserProfilePage.dart';
import 'package:morflutter/starting_pages/ui/sbk101/about_sbk101.dart';
import 'package:morflutter/starting_pages/ui/sbk101/my_sbk101.dart';

class MorfoHomeNavBar extends StatefulWidget {
  const MorfoHomeNavBar({super.key});

  @override
  State<MorfoHomeNavBar> createState() => _MorfoHomeNavBarState();
}

class _MorfoHomeNavBarState extends State<MorfoHomeNavBar> {
  int selectedIndex = 0;

  void _navigate(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // pages list
  final List<Widget> tabs = [
    AboutSbk101(),
    MySbk101(),
    databaseReadTest(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: tabs[selectedIndex]),
      bottomNavigationBar: Container(
        color: lilyPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: GNav(
              backgroundColor: lilyPurple,
              color: draculaPurple,
              tabBackgroundColor: darkPeriwinkle,
              padding: EdgeInsets.all(15),
              onTabChange: _navigate,
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.perm_device_information_rounded,
                  text: 'Mi SBK-101',
                ),
                GButton(icon: Icons.search, text: 'Servicios'),
                GButton(icon: Icons.data_saver_off_outlined, text: 'Datos EMG'),
                GButton(
                  icon: Icons.person,
                  text: 'Perfil',
                ),
              ]),
        ),
      ),
    );
  }
}
