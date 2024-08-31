import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/dashboard_fragments/home_thread/chatbot_screen.dart';
import 'package:doctor/screens/login.dart';

import 'package:doctor/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/authmethods.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Authentication authentication = Authentication();
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
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              children: [
                  const Gap(8),
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: const Color(0xff0D1B34),
                      height: 1,
                    ),
                  ),
                  const Gap(20),
                  Container(
                    height: 138,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 71, 130, 249),
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/imran.png',
                            width: 48,
                            height: 48,
                          ),
                        ),
                        const Gap(14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userDetails.isEmpty
                                ? Container()
                                : Text(
                                    userDetails['name'] ?? '',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: const Color(0xffFFFFFF),
                                      height: 1,
                                    ),
                                  ),
                            const Gap(2),
                            Text(
                              userDetails['email'] ?? '',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: const Color(0xffCBE1FF),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'ACCOUNT',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: const Color(0xff0D1B34),
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xffFAFAFA),
                    ),
                    child: Column(children: [
                      buildCard('assets/images/edit_personal_details.png',
                          'Edit personal details'),
                      const Gap(8),
                      buildCard(
                          'assets/images/my_communities.png', 'My Communities'),
                      const Gap(8),
                      buildCard(
                          'assets/images/notifications.png', 'Notifications'),
                    ]),
                  ),
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'OTHERS',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: const Color(0xff0D1B34),
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xffFAFAFA),
                    ),
                    child: Column(children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatbotScreen())),
                          child: buildCard(
                              'assets/images/faq.png', 'FAQ & Support')),
                      const Gap(8),
                      buildCard(
                          'assets/images/privacy_policy.png', 'Privacy Policy'),
                      const Gap(8),
                      buildCard('assets/images/about.png', 'About'),
                    ]),
                  ),
                  CustomButton(
                    text: 'Logout',
                    onPressed: () {
                      authentication.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ]),
    );
  }

  Widget buildCard(String imageURL, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(imageURL, fit: BoxFit.contain),
          ),
        ),
        const Gap(14),
        Text(title),
      ],
    );
  }
}
