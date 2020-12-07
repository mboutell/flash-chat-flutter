import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';

class Message {
  String text;
  String senderUid;

  Message(DocumentSnapshot doc) {
    text = doc[kFbMessageText];
    senderUid = doc[kFbMessageSenderUid];
  }

  @override
  String toString() {
    return "$text sent by $senderUid";
  }
}
