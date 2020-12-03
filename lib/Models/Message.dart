import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';

class Message {
  String _text;
  String _senderUid;

  Message(DocumentSnapshot doc) {
    _text = doc[kFbMessageText];
    _senderUid = doc[kFbMessageSenderUid];
  }

  @override
  String toString() {
    return "$_text sent by $_senderUid";
  }
}
