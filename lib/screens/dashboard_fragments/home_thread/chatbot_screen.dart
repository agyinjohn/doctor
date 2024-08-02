import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// import '../models/message.dart';
import '../../../utils/models/message_card_model.dart';

class ChatbotScreen extends ConsumerStatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  final List<Message> _messages = [];
  StreamSubscription<QuerySnapshot>? _chatSubscription;
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _speech = stt.SpeechToText();
    _loadInitialMessages();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chatSubscription?.cancel();
  }

  Future<void> _loadInitialMessages() async {
    _chatSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(_user.uid)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _messages.clear();
          for (var doc in snapshot.docs) {
            final messageData = doc.data();
            _messages.add(Message(
              text: messageData['content'],
              sender: messageData['role'] == 'user'
                  ? MessageSender.user
                  : MessageSender.ai,
            ));
          }
        });
      }
    });
  }

  Future<String> getPostResultFromApi({
    required String userId,
    required String message,
  }) async {
    var url = 'https://chatgpt-api8.p.rapidapi.com/';
    var headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '7f1ef9e40bmshb133680f5a095e7p1ff3aejsnc22cdfa1f0e2',
      'X-RapidAPI-Host': 'chatgpt-api8.p.rapidapi.com',
    };

    String responseText = '';
    message =
        'Please you are suppose to provide answers to people who are using kudiAcces mobile which was created to handle their fanancial records and this is their questions, reply them as finacial trained model for handling fanacial issues question: ${message}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode([
          {'content': message, 'role': 'user'}
        ]),
      );
      print(response.body);
      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      if (jsonResponse.isNotEmpty) {
        responseText = jsonResponse['text'];
      }
    } catch (e) {
      print(e);
    }

    return responseText;
  }

  Future<void> saveMessage(String userId, Map<String, dynamic> message) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .add(message);
    } catch (e) {
      print('Error saving message: $e');
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();

    // Save user's message to Firestore and add to the messages list
    final userMessage = Message(text: text, sender: MessageSender.user);
    setState(() {
      _messages.add(userMessage);
    });
    await saveMessage(_user.uid, {
      'content': userMessage.text,
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Call API to get response
    final aiResponse =
        await getPostResultFromApi(userId: _user.uid, message: text);

    if (mounted) {
      // Save AI response to Firestore and add to the messages list
      final aiMessage = Message(text: aiResponse, sender: MessageSender.ai);
      setState(() {
        _messages.add(aiMessage);
      });
      await saveMessage(_user.uid, {
        'content': aiMessage.text,
        'role': 'ai',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Colors = ref.watch(colorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message.sender == MessageSender.user;
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                          color:
                              isUserMessage ? Colors.white54 : Colors.white54),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        prefixIcon: Icon(
                          Icons.emoji_emotions,
                          color: Colors.white54,
                        ),
                        hintText: 'Message',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                      maxLines: 1,
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onLongPress: _listen,
                  onLongPressEnd: (details) {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 25,
                    child: GestureDetector(
                      onTap: _controller.text.isEmpty ? null : _sendMessage,
                      child: Icon(
                        _controller.text.isEmpty ? Icons.mic : Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
