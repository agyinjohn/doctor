import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/notepad.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:gap/gap.dart';

class EditJournalScreen extends StatelessWidget {
  final String title;
  final String date;
  final String content;
  final String id;
  const EditJournalScreen({
    super.key,
    required this.title,
    required this.date,
    required this.content,
    required this.id,
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
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                bool confirmed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete Note'),
                                      content: Text(
                                          'Are you sure you want to delete this note?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmed) {
                                  await FirebaseFirestore.instance
                                      .collection('notes')
                                      .doc(id)
                                      .delete();
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            IconButton(
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEditNote(
                                              content: content,
                                              id: id,
                                              title: title,
                                            )));
                              },
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
