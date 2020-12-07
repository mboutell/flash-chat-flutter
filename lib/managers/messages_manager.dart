import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Models/Message.dart';
import 'package:flash_chat/constants.dart';

class MessagesManager {
  CollectionReference _ref;
  Function _callback;
  bool _error = true;
  bool _waiting = true;
  var docs = List<DocumentSnapshot>();

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

    var onData = (querySnapshot) {
      _error = false;
      _waiting = false;
      docs = querySnapshot.docs;
      for (var doc in docs) {
        print(doc);
      }
      if (callback != null) {
        _callback();
      }
    };

    _ref.limit(50).orderBy(kFbMessageCreated).snapshots().listen(onData,
        onError: (error) {
      _logError(error);
    });
  }

  void _logError(var error) {
    print("Error: $error");
    _error = true;
  }

  void stopListening() {
    _callback = null;
  }

  Future<void> addMessage(String text, String uid) {
    return _ref
        .add({
          kFbMessageText: text,
          kFbMessageSenderUid: uid,
          kFbMessageCreated: FieldValue.serverTimestamp(),
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }

  Message getMessageAt(int index) => Message(docs[index]);

  int length() => docs.length;

  Stream get stream => _ref.snapshots();

  bool get error => _error;
  bool get waiting => _waiting;
}
