import 'package:doctor/screens/dashboard_fragments/therapy_thread/connect_to_therapist_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor/widgets/custom_button.dart';
import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';

class TherapyFragment extends StatefulWidget {
  const TherapyFragment({super.key});

  @override
  State<TherapyFragment> createState() => _TherapyFragmentState();
}

class _TherapyFragmentState extends State<TherapyFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(48),
            _buildPageHeading(),
            const Gap(12),
            _buildIllustration(),
            const Gap(20),
            _buildButton(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildPageHeading() {
  return const Text(
    'Get help \nfrom professionals',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      // letterSpacing: -2,
    ),
  );
}

Widget _buildIllustration() {
  return Center(
      child: Image.asset(
    'assets/images/doctors.png',
    height: 350.0,
  ));
}

Widget _buildButton(BuildContext context) {
  return CustomButton(
      text: 'Connect to a therapist',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ConnectToTherapistPage()));
      });
}
