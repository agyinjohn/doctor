import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../widgets/custom_button.dart';
import '../../therapy_thread/connect_to_therapist_page.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              const Gap(38),
              _buildPageHeading(),
              const Gap(18),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Hey Krisy! \nBased on your responses, your mental health status is "Mild to Moderate" risk.'),
                    Gap(32),
                    Text(
                      'MILD TO MODERATE RISK:',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 18),
                    ),
                    Gap(8),
                    Text(
                        'Your responses indicate that you may be experiencing mild to moderate mental health issues.\nWe recommended seeking further support from a mental health professional to address these concerns.'),
                    Gap(14),
                    Text('You can check our "Connect to a Therapist" page.'),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Connect to a therapist',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ConnectToTherapistPage()));
                },
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        'Self-Assessment Results',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
