class Note {
  String id;
  String title;
  String content;
  DateTime timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Note fromMap(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
