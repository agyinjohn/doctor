// import 'package:flutter/material.dart';

// import '../../../utils/data/doctors_list.dart';
// import '../../chat_screen.dart';

// class ChatWithProfessionalScreen extends StatefulWidget {
//   const ChatWithProfessionalScreen({super.key});

//   @override
//   State<ChatWithProfessionalScreen> createState() =>
//       _ChatWithProfessionalScreenState();
// }

// class _ChatWithProfessionalScreenState
//     extends State<ChatWithProfessionalScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Doctors'),
//       ),
//       body: ListView.builder(
//         itemCount: doctors.length,
//         itemBuilder: (context, index) {
//           final doctor = doctors[index];
//           return ListTile(
//             title: Text(doctor.name),
//             subtitle: Text(doctor.specialty),
//             trailing: const Icon(Icons.message),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatScreen(doctor: doctor),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
