import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/authmethods.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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

  Future<List<Map<String, dynamic>>> getAdministrators() async {
    // Reference to the Firestore collection
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');

    // Query to get all users where the role is 'admin'
    QuerySnapshot querySnapshot =
        await usersRef.where('role', isEqualTo: 'admin').get();

    // Map the documents to a list of Maps containing user data
    List<Map<String, dynamic>> adminUsers = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return adminUsers;
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
    final TextEditingController _searchController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Text(
                userDetails['name'] ?? '',
                style: TextStyle(
                    color: Color.fromARGB(255, 37, 37, 37),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Administrator',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),

              //Search bar
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: 55,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    prefixIcon: Icon(IconlyLight.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  // maxLines: 1,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff4894FE), width: 2.6),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage\nProfessionals',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'and administrators with ease',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Administrators",
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xff0D1B34),
                      // height: 0,
                    ),
                  ),
                  const Gap(6),
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: getAdministrators(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text('No administrators found.'));
                        }
                        final admins = snapshot.data!;
                        return ListView.builder(
                          itemCount: admins.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            final admin = admins[index];
                            String image = 'assets/images/joseph.png';
                            String name = admin['name'];
                            String specialist = 'Administrator';
                            // String range = '1.2 KM';
                            double rate = 4.8;
                            int review = 120;
                            String open = '17.00';
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    offset: const Offset(2, 12),
                                    color: const Color(0xff5A75A7)
                                        .withOpacity(0.1),
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
                                      const Gap(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: const Color(0xff0D1B34),
                                                height: 1,
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              specialist,
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 11,
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
                                            width: 10,
                                            height: 10,
                                          ),
                                          const Gap(8),
                                          // Text(
                                          //   range,
                                          //   style: GoogleFonts.poppins().copyWith(
                                          //     fontWeight: FontWeight.normal,
                                          //     fontSize: 14,
                                          //     color: const Color(0xff8696BB),
                                          //     height: 1,
                                          //   ),
                                          // ),
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
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
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
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
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
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
