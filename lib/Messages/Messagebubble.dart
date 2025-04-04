import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key,this.sender,this.text,this.isMe});
  final String? sender;
  final String? text;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: (isMe??true) ?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender!,style: TextStyle(
            fontSize: 12,color: Colors.black54,
          ),),
          Material(
              elevation: 5,
              borderRadius:(isMe ?? true)
                  ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
                  : BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: (isMe ?? true) ? Colors.lightBlueAccent:Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                child: Text(text!,
                    style: TextStyle(
                      color: (isMe ?? true)?Colors.white:Colors.black54,
                      fontSize: 15,
                    )),
              )
          ),
        ],
      ),
    );
  }
}