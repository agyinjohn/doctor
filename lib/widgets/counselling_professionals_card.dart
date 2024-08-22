import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/models/doctor_model.dart';

class CounsellingProfessionalsCard extends StatelessWidget {
  final DoctorModel doctor;

  const CounsellingProfessionalsCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          doctor.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      doctor.specialty,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      doctor.name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert_outlined),
            ],
          ),
        ),
        const Gap(14),
      ],
    );
  }
}
