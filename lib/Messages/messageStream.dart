import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';


import 'Messagebubble.dart';


class Messagestream extends StatelessWidget {
   Messagestream({super.key});
  final _firestore=FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );// Placeholder if no data
        }

        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages!) {
          final data = message.data() as Map<String, dynamic>;
          final messageText = data['text'];
          final messageSender = data['sender'];
          final currentUser=loggedInUser?.email;


          final messageBubble = MessageBubble(
            sender: messageSender,text: messageText,
            isMe: currentUser==messageSender,
          );

          messageBubbles.add(messageBubble);
        }

        return  Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
