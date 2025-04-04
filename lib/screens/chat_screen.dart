import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Messages/messageStream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
final _firestore=FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController=TextEditingController();
  final _auth =FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async {
    try{
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      //print(loggedInUser!.email);
    }
  }catch (e){
    print(e);
  }}
  // // void getMessage() async{
  // //   final messages= await _firestore.collection('messages').get();
  // //   for (var message in messages.docs){
  // //     print(message.data());
  // //
  // //   }
  // // }
  //
  // void messagesStream() async{
  //    await for (var snapshot in _firestore.collection('messages').snapshots()) {//subscribe to my self to listen for changes to my collection of messages// by using snapshot collection it helps us to print data automatilly to our console or on our chat page when ever we get new data we get notified in app
  //      for (var message in snapshot.docs) {
  //        print(message.data());
  //      }; //it is type of list of future object
  //    }}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //getMessage();

                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
        Messagestream(),
               Container(

                decoration: kMessageContainerDecoration,
                child: Row(
                 // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText=value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
messageTextController.clear();
              _firestore.collection('messages').add({'text':messageText,'sender':loggedInUser?.email,
                      },);},
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                   ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}

