import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../utils/data/assessment_questions.dart';
import '../../../../widgets/custom_button.dart';
import 'assessment_completion_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestionIndex = 0;
  List<String?> _answers = List.filled(assessmentQuestions.length, null);
  bool _isTapped = false;

  void _nextQuestion() {
    if (_currentQuestionIndex < assessmentQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CompletionScreen(),
        ),
      );
    }
  }

  void _selectAnswer(String answer) {
    setState(() {
      _answers[_currentQuestionIndex] = answer;
      _nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = assessmentQuestions[_currentQuestionIndex]['question'];
    final answers =
        assessmentQuestions[_currentQuestionIndex]['answers'] as List<String>;

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
                  if (_currentQuestionIndex > 0) {
                    setState(() {
                      _currentQuestionIndex--;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  setState(() {
                    _isTapped = true;
                  });
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: _isTapped ? Colors.blue : Colors.black,
                ),
              ),
              const Gap(18),
              _buildPageHeading(),
              const Gap(18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.62,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${_currentQuestionIndex + 1}: $question',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const Spacer(),
                    const Gap(12),
                    ...answers.map(
                      (answer) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8),
                        child: CustomButton(
                          text: answer,
                          onPressed: () => _selectAnswer(answer),
                        ),
                      ),
                    ),
                  ],
                ),
                //
              ),
              const Spacer(),
              CustomButton(
                text: _currentQuestionIndex < assessmentQuestions.length - 1
                    ? 'Next'
                    : 'Submit',
                onPressed: _nextQuestion,
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Text(
      'Self-Assessment Test',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//  Row(
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 doctor.imageUrl,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const Positioned(
//             top: 0,
//             right: 0,
//             child: Padding(
//               padding: EdgeInsets.all(3.0),
//               child: CircleAvatar(
//                 radius: 6,
//                 backgroundColor: Colors.white,
//                 child: Center(
//                   child: Icon(
//                     Icons.circle,
//                     color: Colors.green,
//                     size: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     const Gap(2),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           doctor.specialty,
//           softWrap: false,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(fontSize: 13),
//         ),
//         Text(
//           doctor.name,
//           softWrap: false,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//       ],
//     ),
//     const Spacer(),
//     const Icon(Icons.more_vert_outlined),
//   ],
// ),
