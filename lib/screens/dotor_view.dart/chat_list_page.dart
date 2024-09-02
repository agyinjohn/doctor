import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/utils/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat_screen.dart';

class ChatOverviewScreen extends StatefulWidget {
  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> _userDetails = {};
  bool _isLoading = true;
  List<String> _senderIds = []; // List to store unique sender IDs

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
      _userDetails = doc.data() as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Chats', style: TextStyle(color: Colors.white),),
              elevation: 2,
              
            ),
            body: StreamBuilder(stream: FirebaseFirestore.instance.collection('chats').doc(FirebaseAuth.instance.currentUser!.uid).collection('chat').snapshots(), builder:(context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child:  CircularProgressIndicator(),);
              }
             else if(snapshot.hasError){
                Center(child: Text('${snapshot.error}'),);
              }else if(!snapshot.hasData || !snapshot.data!.docs.isNotEmpty){
                  return Center(child: Text('Not found'),);
              }
              final chats = snapshot.data!.docs;
              // print(chats['text']);
              return ListView.builder(itemBuilder:(context, index) => InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(doctor: DoctorModel(name: '', id: chats[index]['sender'], specialty: '', imageUrl: '')))),
                child: ListTile(leading: CircleAvatar(child: Icon(Icons.person,),
                  
                ),
                subtitle: Text(chats[index]['lastMessage']),
                title: Text(chats[index]['sendername']),
                ),
              ),
                itemCount: chats.length,
               );
            },),
          );
  }
}
