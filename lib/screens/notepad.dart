import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/models/note_model.dart';
import 'package:intl/intl.dart';

import 'dashboard_fragments/meditate_thread/edit_journal_screen.dart'; // To format timestamps

class NotePad extends StatefulWidget {
  @override
  _NotePadState createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Journals'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final notes = snapshot.data!.docs
                    .map((doc) => Note.fromMap(
                        doc.data() as Map<String, dynamic>, doc.id))
                    .where((note) =>
                        note.title.contains(_searchTerm) ||
                        note.content.contains(_searchTerm))
                    .toList();
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notes[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                      'Written on: ${DateFormat('yyyy-MM-dd – kk:mm').format(notes[index].timestamp)}'),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditJournalScreen(
                                                id: notes[index].id,
                                                content: notes[index].content,
                                                date: notes[index]
                                                    .timestamp
                                                    .toString(),
                                                title: notes[index].title,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 16.0,
                                          ),
                                          child: const Text(
                                            'Continue Writing',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditNote(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddEditNote extends StatefulWidget {
  String? title;
  String? content;
  String? id;

  AddEditNote({this.content, this.title, this.id});

  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.content == null ? 'Add Jornal' : 'Edit Journal'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.content == null
                        ? 'Create a new journal'
                        : 'Edit your journal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSaved: (value) {
                      widget.title = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.content,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSaved: (value) {
                      widget.content = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                    maxLines: 5,
                    minLines: 3,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 15.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.content == null ? 'Add Note' : 'Update Note',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                _formKey.currentState!.save();
                                final note = Note(
                                  id: widget.id ??
                                      FirebaseFirestore.instance
                                          .collection('notes')
                                          .doc()
                                          .id,
                                  title: widget.title!,
                                  content: widget.content!,
                                  timestamp: DateTime.now(),
                                );

                                try {
                                  if (widget.content == null) {
                                    await FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(note.id)
                                        .set(note.toMap());
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(note.id)
                                        .update(note.toMap());
                                  }
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pop(context);
                                }
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class NoteDetail extends StatelessWidget {
  final Note note;

  NoteDetail({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditNote(
                    content: note.content,
                    id: note.id,
                    title: note.title,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(note.content),
      ),
    );
  }
}



// Widget _buildMyJournals() {
//     return ListView.builder(
//       itemCount: journals.length,
//       itemBuilder: (context, index) {
//         final journal = journals[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: 
//         );
//       },
//     );
//   }