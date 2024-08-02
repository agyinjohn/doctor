// import 'package:doctor/screens/dashboard_fragments/therapy_thread/connect_to_therapist_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor/widgets/custom_button.dart';
import 'package:gap/gap.dart';

import 'todays_resources.dart';
// import 'package:google_fonts/google_fonts.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourceScreen> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isTapped = true;
                  });
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: _isTapped ? Colors.blue : Colors.black,
                ),
              ),
              const Gap(32),
              _buildPageHeading(),
              const Gap(12),
              _buildIllustration(context),
              const Gap(38),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPageHeading() {
  return const Text(
    'Access to real resources',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 42,
      fontWeight: FontWeight.bold,
      // letterSpacing: -2,
    ),
  );
}

Widget _buildIllustration(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width * 0.9;

  return Center(
      child: SizedBox(
          height: screenWidth,
          width: screenWidth,
          child: Image.asset('assets/images/resources.jpg')));
}

Widget _buildButton(BuildContext context) {
  return CustomButton(
      text: 'Get a ton of resources',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TodaysResourcesScreen()));
      });
}
