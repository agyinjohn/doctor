import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor/screens/meeting_screen.dart';
import 'package:doctor/utils/models/doctor_model.dart';
import 'package:doctor/utils/models/message_card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  final DoctorModel doctor;

  const ChatScreen({super.key, required this.doctor});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String generateChatId(String userAId, String userBId) {
    return userAId.compareTo(userBId) < 0
        ? '${userAId}_$userBId'
        : '${userBId}_$userAId';
  }

  Future<void> sendMessage(String text) async {
    String chatId = generateChatId(userDetails['uid'], widget.doctor.id);
    // var random = Random();
    // String chatId = (random.nextInt(10000000) + 10000000).toString();
    final messageRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'messageId': messageRef.id,
      'senderId': userDetails['uid'],
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> userDetails = {};
  bool isLoading = true;
  String chatId = '';
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    // print('Hey yaaa' + widget.doctor.id);
    try {
      DocumentSnapshot doc = await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data);
      setState(() {
        userDetails = data;
        isLoading = false;
      });
      print(userDetails);
      chatId = generateChatId(userDetails['uid'], widget.doctor.id);
      print(userDetails['uid']);
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final JitsiMeet _jitsiMeetMethods = JitsiMeet();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000000000).toString();

    var options = JitsiMeetConferenceOptions(
      room: roomName,
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
      },
      featureFlags: {
        FeatureFlags.lobbyModeEnabled: false, // Disable lobby mode
        // Other feature flags...
      },
      userInfo: JitsiMeetUserInfo(
          displayName: userDetails['name'],
          email: userDetails['email'],
          avatar:
              "https://avatars.githubusercontent.com/u/57035818?s=400&u=02572f10fe61bca6fc20426548f3920d53f79693&v=4"),
    );
    _jitsiMeetMethods.join(options);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    createNewMeeting();
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
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatId)
                        .collection('messages')
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final messages = snapshot.data!.docs;

                        // print(messages.length);
                        print(chatId);
                        return ListView.builder(
                          reverse: false,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final messageData =
                                messages[index].data() as Map<String, dynamic>;

                            // final message = messages[index];
                            // print(message[index]['text'].toString());
                            return Align(
                              alignment:
                                  messageData['senderId'] == userDetails['uid']
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  padding: EdgeInsets.all(12.0),
                                  constraints: BoxConstraints(
                                      maxWidth: 250, minHeight: 20),
                                  decoration: BoxDecoration(
                                    color: messageData['senderId'] ==
                                            userDetails['uid']
                                        ? Colors.blue[300]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        messageData['text'],
                                        style: TextStyle(
                                          color: messageData['senderId'] ==
                                                  userDetails['uid']
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        _formatTimestamp(
                                            messageData['timestamp']
                                                as Timestamp?),
                                        style: TextStyle(
                                          color: messageData['senderId'] ==
                                                  userDetails['uid']
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            // subtitle: Text(message['senderId']),
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Padding(
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
                              sendMessage(text);
                              setState(() {
                                // Simulating doctor's response

                                _messageController.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Stack(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 70.0, top: 10),
            //       child: ListView.builder(
            //         itemCount: _messages.length,
            //         itemBuilder: (context, index) {
            //           final message = _messages[index];
            //           final isUser = message.sender == MessageSender.user;

            //           return Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //             child: Row(
            //               mainAxisAlignment: isUser
            //                   ? MainAxisAlignment.end
            //                   : MainAxisAlignment.start,
            //               // crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 if (!isUser)
            //                   CircleAvatar(
            //                     backgroundImage:
            //                         AssetImage(widget.doctor.imageUrl),
            //                     radius: 20,
            //                   ),
            //                 if (!isUser) const Gap(8),
            //                 Flexible(
            //                   child: Container(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 14, vertical: 10),
            //                     margin: const EdgeInsets.symmetric(vertical: 5),
            //                     decoration: BoxDecoration(
            //                       color: isUser
            //                           ? Colors.blue[100]
            //                           : Colors.grey[300],
            //                       borderRadius: BorderRadius.circular(10),
            //                     ),
            //                     child: Text(message.text),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     ),

            //   ],
            // ),
          );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return '';
    DateTime date = timestamp.toDate();
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
