import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Models/Message.dart';
import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flash_chat/managers/messages_manager.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final scrollController = ScrollController();
  String message;

  @override
  void initState() {
    super.initState();
    print("User in chat: ${AuthManager().email}");
    MessagesManager().beginListening(() {
      // print("Callback got something on the stream");
      // for (int k = 0; k < MessagesManager().length(); k++) {
      //   print("Message $k is ${MessagesManager().getMessageAt(k)}");
      // }
      setState(() {/* no-op */});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("building chat screen");
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                AuthManager().signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getMessageViews(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      MessagesManager().addMessage(message, AuthManager().uid);
                      messageTextController.clear();
                    },
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

  Widget getMessageViews() {
    if (MessagesManager().error) {
      return Expanded(child: Center(child: Text("Something went wrong")));
    }

    if (MessagesManager().waiting) {
      return Expanded(
        child: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        )),
      );
    }

    // If I used a StreamBuilder,
    // snapshot is Flutter's AsyncSnapshot, it's .data is a FB querySnapshot.

    Timer(
      Duration(milliseconds: 0),
      () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );

    return Expanded(
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: MessagesManager().docs.map((DocumentSnapshot doc) {
          return MessageBubble(Message(doc));
        }).toList(),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(message.senderUid,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              )),
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                message.text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
