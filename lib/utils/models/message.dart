enum MessageSender { user, doctor }

class Message {
  final String text;
  final MessageSender sender;

  Message({required this.text, required this.sender});
}
