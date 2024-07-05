// lib/doctor_list_screen.dart

import 'package:doctor/screens/doctor_detailscreen.dart';
import 'package:doctor/utils/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorListScreen extends StatelessWidget {
  final List<DoctorModel> doctors = [
    DoctorModel(name: 'Dr. Alice', specialty: 'Cardiologist', id: "12"),
    DoctorModel(name: 'Dr. Bob', specialty: 'Dermatologist', id: "899"),
    // Add more doctors here
  ];

  DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialty),
            trailing: const Icon(Icons.message),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(doctor: doctor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
