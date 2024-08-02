import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:gap/gap.dart';

class EditJournalScreen extends StatelessWidget {
  final String title;
  final String date;
  final String content;

  const EditJournalScreen({
    super.key,
    required this.title,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                date,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Text(
                          content,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Gap(22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              color: Colors.blue,
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () {},
                            ),
                            IconButton(
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
