import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Models/Message.dart';
import 'package:flash_chat/constants.dart';

class MessagesManager {
  CollectionReference _ref;
  Function _callback;
  var _docs = List<DocumentSnapshot>();

  static final MessagesManager _instance =
      MessagesManager._privateConstructor();

  factory MessagesManager() {
    return _instance;
  }

  MessagesManager._privateConstructor() {
    print("Creating messages manager");
    _ref = FirebaseFirestore.instance.collection(kFbMessagesPath);
  }

  void beginListening(callback) {
    _callback = callback;

    _ref.limit(50).snapshots().listen((querySnapshot) {
      _docs = querySnapshot.docs;
      for (var doc in _docs) {
        print(doc);
      }
      if (callback != null) {
        _callback();
      }
    });
  }

  void stopListening() {
    _callback = null;
  }

  Future<void> addMessage(String text, String uid) {
    return _ref
        .add({
          kFbMessageText: text,
          kFbMessageSenderUid: uid,
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }

  Message getMessageAt(int index) => Message(_docs[index]);

  int length() => _docs.length;

  Stream get stream => _ref.snapshots();
}
