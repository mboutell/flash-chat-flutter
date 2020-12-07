import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

var kTextFieldEmailDecoration =
    kTextFieldDecoration.copyWith(hintText: 'Enter your email');

var kTextFieldPasswordDecoration = kTextFieldDecoration.copyWith(
  hintText: 'Enter your password',
);

const kRouteLogin = "login";
const kRouteWelcome = "welcome";
const kRouteRegistration = "registration";
const kRouteChat = "chat";

const kTagLogo = "logo";

// CONSIDER: Move to MessagesManager?
const kFbMessagesPath = "messages";
const kFbMessageText = "text";
const kFbMessageSenderUid = "senderUid";
const kFbMessageCreated = "created";
