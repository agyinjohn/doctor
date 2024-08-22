import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../widgets/custom_button.dart';
import 'assessment_screen.dart';

class AssessmentInstructionScreen extends StatelessWidget {
  const AssessmentInstructionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black),
                ),
                const Gap(12),
                _buildPageTitle(
                    context, 'Instructions for taking this assessment test'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                          ),
                          const Gap(8),
                          const Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Find a quiet, comfortable space where you won\'t be interrupted.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                          ),
                          const Gap(8),
                          const Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Read each question carefully and select the response that best describes your feeling.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                          ),
                          const Gap(8),
                          const Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'There are no right or wrong answers, so be honest with yourself and always feel free to go back to the previous question, if necessary.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                          ),
                          const Gap(8),
                          const Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Click on "Next" to move to the next question and "Submit" to see your results.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      _buildPageTitle(context, 'Disclaimer'),
                      const Text(
                        'The results of this self-assessment test are not a diagnosis and should not used as substitute for professional medical advice. \nThe test is designed to provide an initial indication of mental health and emotional wellbeing, and should not be used to make health decisions without consulting a qualified medical or mental health professional. \nIf concerned about mental, please check our "Connect with a therapish" page.',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Start Now',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssessmentScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
