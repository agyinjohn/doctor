import 'package:doctor/screens/admin/quick_action_page.dart';
import 'package:doctor/screens/admin/statistics.dart';
import 'package:doctor/screens/admin/user_management.dart';
import 'package:doctor/screens/dotor_view.dart/chat_list_page.dart';
import 'package:doctor/screens/dotor_view.dart/main_home.dart';
// import 'package:doctor/screens/dashboard_fragments/meditate_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../admin/admin_home_page.dart';
import '../admin/resources_page.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});
  static const routeName = '/doctor-dashboard';
  @override
  State<DoctorHomePage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DoctorHomePage> {
  int index = 0;

  List menu = [
    {
      'icon': Icon(IconlyBroken.home),
      // 'assets/images/ic_home.png',
      'icon_active': Icon(IconlyBold.home),
      'label': 'Home',
      'fragment': const MainHome(),
    },
    {
      'icon': Icon(IconlyBroken.chat),
      'icon_active': Icon(IconlyBold.chat),
      'label': 'Chats',
      'fragment':  ChatOverviewScreen(),
    },
    {
      'icon': Icon(IconlyBroken.profile),
      'icon_active': Icon(IconlyBold.paper),
      'label': 'Profile',
      'fragment': ProfileFragment(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 235, 237, 235),
      body: SafeArea(child: menu[index]['fragment'] as Widget),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SalomonBottomBar(
          currentIndex: index,
          onTap: (newIndex) {
            index = newIndex;
            setState(() {});
          },
          itemShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemPadding: const EdgeInsets.all(12),
          selectedItemColor: const Color.fromARGB(255, 46, 133, 214),
          items: menu.map((item) {
            return SalomonBottomBarItem(
              icon: item['icon'],
              activeIcon: item['icon_active'],
              title: SizedBox(
                width: 50,
                child: Text(
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  item['label'],
                  style: GoogleFonts.nunito().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              selectedColor: const Color(0xff63B4FF),
              unselectedColor: const Color(0xff8696BB),
            );
          }).toList(),
        ),
      ),
    );
  }
}
