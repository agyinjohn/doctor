import 'package:doctor/screens/meeting_screen.dart';
import 'package:doctor/utils/models/doctor_model.dart';
import 'package:doctor/utils/models/message_card_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatScreen extends StatefulWidget {
  final DoctorModel doctor;

  const ChatScreen({super.key, required this.doctor});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeetingScreen()),
              );
            },
            icon: const Icon(
              Icons.video_call_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              size: 30,
            ),
          ),
        ],
        elevation: 10,
        title: Text(widget.doctor.name),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0, top: 10),
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.sender == MessageSender.user;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser)
                        CircleAvatar(
                          backgroundImage: AssetImage(widget.doctor.imageUrl),
                          radius: 20,
                        ),
                      if (!isUser) const Gap(8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(message.text),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          prefixIcon: Icon(Icons.emoji_emotions),
                          hintText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      color: Colors.lightGreen,
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = _messageController.text;
                        if (text.isNotEmpty) {
                          setState(() {
                            _messages.add(Message(
                                text: text, sender: MessageSender.user));
                            _messages.add(Message(
                                text: 'Response from ${widget.doctor.name}',
                                sender: MessageSender
                                    .doctor)); // Simulating doctor's response
                            _messageController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
