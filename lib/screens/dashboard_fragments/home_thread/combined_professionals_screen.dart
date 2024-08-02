import 'package:doctor/utils/data/combined_professionals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../utils/data/doctors_list.dart';
import '../../../widgets/counselling_professionals_card.dart';
import '../../chat_screen.dart';

class ProfessionalsScreen extends ConsumerWidget {
  const ProfessionalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12, 12.0, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined,
                            color: Colors.black),
                      ),
                      Gap(68),
                      Text(
                        'All Professionals',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Find professionals by category',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.grey[300],
                        ),
                        child: const TabBar(
                          padding: EdgeInsets.all(3.4),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            Tab(
                              child: Text(
                                textAlign: TextAlign.center,
                                'Academic\nTutors',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                textAlign: TextAlign.center,
                                'Health\nProfessionals',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                textAlign: TextAlign.center,
                                'Counsellors',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(12),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTutorsTab(),
                        _buildHealthProfessionalsTab(),
                        _buildCounsellorsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPageHeading() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'All Professionals',
  //           style: TextStyle(
  //             color: Colors.blue,
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Gap(12),
  //         Text(
  //           'Find professionals by category',
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 12,
  //             // fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTutorsTab() {
    return Column(
      children: [
        Text(
          'Academic Tutors',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tutors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(doctor: tutors[index]),
                    ),
                  );
                },
                child: CounsellingProfessionalsCard(
                  doctor: tutors[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHealthProfessionalsTab() {
    return Column(
      children: [
        Text(
          'Health Professionals',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: healthProfessionals.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(doctor: healthProfessionals[index]),
                    ),
                  );
                },
                child: CounsellingProfessionalsCard(
                  doctor: healthProfessionals[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCounsellorsTab() {
    return Column(
      children: [
        Text(
          'Counsellors',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: counselors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(doctor: counselors[index]),
                    ),
                  );
                },
                child: CounsellingProfessionalsCard(
                  doctor: counselors[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
