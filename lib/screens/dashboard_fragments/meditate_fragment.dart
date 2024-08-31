// lib/doctor_list_screen.dart

import 'package:doctor/screens/chat_screen.dart';
import 'package:doctor/utils/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/custom_button.dart';
import 'meditate_thread/my_journals_screen.dart';

class MeditateFragment extends StatefulWidget {
  MeditateFragment({super.key});

  @override
  State<MeditateFragment> createState() => _MeditateFragmentState();
}

class _MeditateFragmentState extends State<MeditateFragment> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(58),
            _buildPageHeading(),
            const Gap(12),
            _buildIllustration(context),
            const Gap(38),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Text(
      'Unlock your \nemotions by writing',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 38,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 1.15;

    return Center(
        child: SizedBox(
            height: screenWidth,
            width: screenWidth,
            child: Image.asset(
              'assets/images/take_notes.png',
            )));
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
        text: 'Start Jounaling Today',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyJournalsScreen()));
        });
  }
}
