enum MessageSender { user, doctor, ai }

class Message {
  final String text;
  final MessageSender sender;

  Message({required this.text, required this.sender});
}

class MessageData {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;

  MessageData({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  // Method to convert a Message object to a Map (for storing in Firebase)
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Method to create a Message object from a Map (retrieved from Firebase)
  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      content: map['content'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
