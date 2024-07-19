import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/data/doctors_list.dart';
import '../../../widgets/counselling_professionals_card.dart';
import '../../chat_screen.dart';

class AllProfessionalsScreen extends StatefulWidget {
  const AllProfessionalsScreen({super.key});

  @override
  State<AllProfessionalsScreen> createState() => _AllProfessionalsScreenState();
}

class _AllProfessionalsScreenState extends State<AllProfessionalsScreen> {
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
              const Gap(18),
              _buildPageHeading(),
              const Gap(16),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(doctor: doctors[index]),
                          ),
                        );
                      },
                      child: CounsellingProfessionalsCard(
                        doctor: doctors[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeading() {
    return const Text(
      'All Professionals',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}





//import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// import '../../../utils/data/doctors_list.dart';
// import '../../../widgets/counselling_professionals_card.dart';
// import '../../chat_screen.dart';
// // import 'chat_with_professional.dart';

// class AllProfessionalsScreen extends StatefulWidget {
//   const AllProfessionalsScreen({super.key});

//   @override
//   State<AllProfessionalsScreen> createState() => _AllProfessionalsScreenState();
// }

// class _AllProfessionalsScreenState extends State<AllProfessionalsScreen> {
//   bool _isTapped = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Gap(20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   setState(() {
//                     _isTapped = true;
//                   });
//                 },
//                 child: Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: _isTapped ? Colors.blue : Colors.black,
//                 ),
//               ),
//               const Gap(18),
//               _buildPageHeading(),
//               const Gap(16),
//               Expanded(
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: doctors.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const ChatScreen(doctor: doctor,)));
//                       },
//                       child: CounsellingProfessionalsCard(
//                         doctor: doctors[index],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPageHeading() {
//     return const Text(
//       'All Professionals',
//       style: TextStyle(
//         color: Colors.blue,
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
