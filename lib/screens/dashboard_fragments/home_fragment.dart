import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/dashboard_fragments/home_thread/assessment_questions_thread/assessment_instructions_screen.dart';
import 'package:doctor/screens/dashboard_fragments/home_thread/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'home_thread/chatbot_screen.dart';
import 'home_thread/combined_professionals_screen.dart';
import 'profile_thread/edit_profile_screen.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});
  static const routeName = "/homscreen";

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> userDetails = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    try {
      DocumentSnapshot doc = await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data);
      setState(() {
        userDetails = data;
        isLoading = false;
      });
      print(userDetails);
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            children: [
              const Gap(64),
              buildHeader(context, userDetails),
              const Gap(30),
              buildMyAppointment(),
              const Gap(24),
              buildSearch(),
              const Gap(24),
              buildCategories(context),
              const Gap(40),
              buildNearDoctor(),
            ],
          );
  }

  Widget buildNearDoctor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Near Doctor",
          style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color(0xff0D1B34),
            height: 1,
          ),
        ),
        const Gap(16),
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            String image = 'assets/images/joseph.png';
            String name = 'Dr. Joseph Brostito';
            String specialist = 'Dental Specialist';
            String range = '1.2 KM';
            double rate = 4.8;
            int review = 120;
            String open = '17.00';
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(2, 12),
                    color: const Color(0xff5A75A7).withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          image,
                          width: 48,
                          height: 48,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color(0xff0D1B34),
                                height: 1,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              specialist,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: const Color(0xff8696BB),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/ic_location.png',
                            width: 16,
                            height: 16,
                          ),
                          const Gap(8),
                          Text(
                            range,
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: const Color(0xff8696BB),
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Divider(
                    color: Color(0xffF5F5F5),
                    height: 1,
                    thickness: 1,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(
                                'assets/images/ic_clock.png',
                              ),
                              size: 20,
                              color: Color(0xffFEB052),
                            ),
                            const Gap(8),
                            Text(
                              '$rate ($review Reviews)',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xffFEB052),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage(
                                'assets/images/ic_clock.png',
                              ),
                              size: 20,
                              color: Color(0xff4894FE),
                            ),
                            const Gap(8),
                            Text(
                              'Open at $open',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xff4894FE),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildCategories(BuildContext context) {
    final categories = [
      {
        'icon': 'assets/images/ic_virus.png',
        'title': 'Resources',
        'Function': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ResourceScreen()));
        },
      },
      {
        'icon': 'assets/images/ic_hospital.png',
        'title': 'Chatbot',
        'Function': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatbotScreen()));
        },
      },
      {
        'icon': 'assets/images/ic_link.png',
        'title': 'Assessment',
        'Function': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AssessmentInstructionScreen()));
        },
      },
      {
        'icon': 'assets/images/ic_profile_add.png',
        'title': 'Professionals',
        'Function': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfessionalsScreen()));
        },
      },
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((e) {
        return Column(
          children: [
            GestureDetector(
              onTap: e['Function']! as VoidCallback,
              child: Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 223, 239, 249),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  e['icon']!.toString(),
                  width: 22,
                  height: 22,
                ),
              ),
            ),
            const Gap(8),
            Text(
              e['title']!.toString(),
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: const Color(0xff8696BB),
                height: 1,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildSearch() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 239, 249),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/images/ic_search.png',
            width: 24,
            height: 24,
          ),
          const Gap(12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search doctor or health issue',
                hintStyle: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: const Color(0xff8696BB),
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildMyAppointment() {
    return Container(
      height: 138,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff4894FE),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/imran.png',
                  width: 48,
                  height: 48,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Imran Syahir',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'General Doctor',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: const Color(0xffCBE1FF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/ic_arrow_right.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const Spacer(),
          Divider(
            color: Colors.white.withOpacity(0.15),
            height: 1,
            thickness: 1,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(
                        'assets/images/ic_calendar.png',
                      ),
                      size: 16,
                      color: Colors.white,
                    ),
                    const Gap(8),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 8,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(
                        'assets/images/ic_clock.png',
                      ),
                      size: 10,
                      color: Colors.white,
                    ),
                    const Gap(8),
                    Text(
                      '11:00 - 12:00 AM',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: const Color(0xff8696BB),
                  height: 1,
                ),
              ),
              const Gap(6),
              Text(
                data['name'] ?? '',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xff0D1B34),
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfilePage()));
          },
          child: Image.asset(
            'assets/images/profile.png',
            width: 56,
            height: 56,
          ),
        ),
      ],
    );
  }
}
