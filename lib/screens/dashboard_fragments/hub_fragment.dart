import 'package:doctor/screens/dashboard_fragments/therapy_thread/connect_to_therapist_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor/widgets/custom_button.dart';
import 'package:gap/gap.dart';

class HubFragment extends StatefulWidget {
  const HubFragment({super.key});

  @override
  State<HubFragment> createState() => _TherapyFragmentState();
}

class _TherapyFragmentState extends State<HubFragment> {
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
            const Gap(24),
            _buildButton(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildPageHeading() {
  return const Text(
    'Got something on your mind?',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 42,
      fontWeight: FontWeight.bold,
      // letterSpacing: -2,
    ),
  );
}

Widget _buildIllustration() {
  return Center(
    child: Image.asset('assets/images/hub_page.jpg'),
  );
}

Widget _buildButton(BuildContext context) {
  return CustomButton(text: 'Get heard', onPressed: () {});
}
